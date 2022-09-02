import 'package:analyzer/dart/element/element.dart';

typedef Matcher<T> = bool Function(T e);

typedef ElementMatcher = Matcher<Element>;
typedef LibraryMatcher = Matcher<LibraryElement>;

ElementMatcher isClass(String name) {
  return (e) => e is ClassElement && e.name == name;
}

ElementMatcher isWithinLibrary(String name) {
  return (e) => e.librarySource!.fullName.startsWith('/$name/');
}

class ImportFinder {
  ImportFinder({
    required this.lib,
    required this.whereElement,
    this.whereLibrary,
  });

  final LibraryElement lib;
  final ElementMatcher whereElement;
  final LibraryMatcher? whereLibrary;

  /// based on importedLibraries from analyzer-4.1.0
  /// lib/src/dart/element/element.dart
  bool recursiveSearch() {
    final libraries = <LibraryElementWithVisibility>{};
    for (final import in lib.imports) {
      final library = import.importedLibrary;
      if (library != null) {
        libraries.add(LibraryElementWithVisibility.root(
          library,
          import.combinators,
        ));
      }
    }

    return libraries.any((lib) => _isExportedRecursivaly(
          lib,
          {lib.lib.librarySource.fullName},
        ));
  }

  bool _isExportedRecursivaly(
    LibraryElementWithVisibility lib,
    Set<String> visited,
  ) {
    if (lib.isRelevant(whereLibrary)) {
      if (lib.libTopLevelExportElements.any(whereElement)) {
        return true;
      }
    }

    return lib.exportedLibraries.any((exported) {
      final name = exported.lib.librarySource.fullName;
      if (!visited.contains(name)) {
        return _isExportedRecursivaly(exported, visited..add(name));
      }
      return false;
    });
  }
}

class LibraryElementWithVisibility {
  LibraryElementWithVisibility(
    this.lib,
    Set<String> shown,
    Set<String> hidden,
    List<NamespaceCombinator> combinators,
  )   : shown = shown.union(combinators.shown),
        hidden = hidden.union(combinators.hidden);

  LibraryElementWithVisibility.root(
    LibraryElement lib,
    List<NamespaceCombinator> combinators,
  ) : this(lib, {}, {}, combinators);

  final LibraryElement lib;
  final Set<String> shown;
  final Set<String> hidden;

  bool isExported(Element e) {
    if (hidden.isEmpty && shown.isEmpty) return true;
    if (shown.isNotEmpty) return shown.contains(e.name);
    return !hidden.contains(e.name);
  }

  bool isRelevant(LibraryMatcher? whereLibrary) {
    return whereLibrary?.call(lib) ?? true;
  }

  Iterable<Element> get libTopLevelExportElements {
    return lib.exportNamespace.definedNames.values.where(isExported);
  }

  /// based on exportedLibraries from analyzer-4.1.0
  /// lib/src/dart/element/element.dart
  List<LibraryElementWithVisibility> get exportedLibraries {
    final libraries = <LibraryElementWithVisibility>{};
    for (final export in lib.exports) {
      final library = export.exportedLibrary;
      if (library != null) {
        libraries.add(LibraryElementWithVisibility(
          library,
          shown,
          hidden,
          export.combinators,
        ));
      }
    }
    return libraries.toList(growable: false);
  }
}

extension on Iterable<NamespaceCombinator> {
  Set<String> get hidden =>
      whereType<HideElementCombinator>().expand((e) => e.hiddenNames).toSet();

  Set<String> get shown =>
      whereType<ShowElementCombinator>().expand((e) => e.shownNames).toSet();
}
