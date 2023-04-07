// Based on:
// From Freezed 2.3.2 packages/freezed/lib/src/tools/recursive_import_locator.dart
// MIT License
//
// Copyright (c) 2020 Remi Rousselet
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';

extension FindAllAvailableTopLevelElements on LibraryElement {
  /// Recursively loops at the import/export directives to know what is available
  /// in the library.
  ///
  /// This function does not guarantees that the elements returned are unique.
  /// It is possible for the same object to be present multiple times in the list.
  Iterable<Element> allVisibleElements() {
    final elements = libraryImports
        .imports()
        .expand((import) => import.library._visibleElements({}, import.key));

    return elements;
  }

  Iterable<Element> _visibleElements(
    Set<String> visitedPaths,
    _LibraryKey key,
  ) sync* {
    yield* topLevelElements;

    for (final directive in libraryExports.exports()) {
      if (!visitedPaths.add(key.toString() + directive.key.toString())) {
        continue;
      }

      yield* directive.library
          ._visibleElements(visitedPaths, directive.key)
          .where(directive.elementIsExported);
    }
  }
}

extension on List<LibraryExportElement> {
  Iterable<_LibraryDirective> exports() {
    return map(_LibraryDirective.fromExport).whereNotNull();
  }
}

extension on List<LibraryImportElement> {
  Iterable<_LibraryDirective> imports() {
    return map(_LibraryDirective.fromImport).whereNotNull();
  }
}

class _LibraryDirective {
  _LibraryDirective({
    required this.hideStatements,
    required this.showStatements,
    required this.library,
  });

  bool elementIsExported(Element element) {
    return (showStatements.isEmpty && hideStatements.isEmpty) ||
        (hideStatements.isNotEmpty && !hideStatements.contains(element.name)) ||
        showStatements.contains(element.name);
  }

  static _LibraryDirective? fromExport(LibraryExportElement export) {
    final library = export.exportedLibrary;
    if (library == null) return null;

    final hideStatements = export.combinators
        .whereType<HideElementCombinator>()
        .expand((e) => e.hiddenNames)
        .toSet();

    final showStatements = export.combinators
        .whereType<ShowElementCombinator>()
        .expand((e) => e.shownNames)
        .toSet();

    return _LibraryDirective(
      hideStatements: hideStatements,
      showStatements: showStatements,
      library: library,
    );
  }

  static _LibraryDirective? fromImport(LibraryImportElement export) {
    final library = export.importedLibrary;
    if (library == null) return null;

    final hideStatements = export.combinators
        .whereType<HideElementCombinator>()
        .expand((e) => e.hiddenNames)
        .toSet();

    final showStatements = export.combinators
        .whereType<ShowElementCombinator>()
        .expand((e) => e.shownNames)
        .toSet();

    return _LibraryDirective(
      hideStatements: hideStatements,
      showStatements: showStatements,
      library: library,
    );
  }

  final Set<String> hideStatements;
  final Set<String> showStatements;
  final LibraryElement library;

  _LibraryKey get key {
    return _LibraryKey(
      hideStatements: hideStatements,
      showStatements: showStatements,
      librarySource: library.source.fullName,
    );
  }
}

/// A unique key for an import/export statement, to avoid visiting a library twice
/// as libraries sometimes have circular dependencies – which would cause an infinite loop.
///
/// We can't simply use the library path, as it's possible for the same library
/// to be exported multiple time:
///
/// ```dart
/// export 'library.dart' show A;
/// export 'library.dart' show B;
/// ```
class _LibraryKey {
  _LibraryKey({
    required this.hideStatements,
    required this.showStatements,
    required this.librarySource,
  });

  final Set<String> hideStatements;
  final Set<String> showStatements;
  final String librarySource;

  @override
  bool operator ==(Object? other) {
    return other is _LibraryKey &&
        librarySource == other.librarySource &&
        const SetEquality<String>()
            .equals(hideStatements, other.hideStatements) &&
        const SetEquality<String>()
            .equals(showStatements, other.showStatements);
  }

  @override
  int get hashCode => Object.hash(
        librarySource,
        const SetEquality<String>().hash(hideStatements),
        const SetEquality<String>().hash(showStatements),
      );

  @override
  String toString() {
    return '(path: $librarySource, hide: $hideStatements, show: $showStatements)';
  }
}
