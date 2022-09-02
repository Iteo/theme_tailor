import 'package:analyzer/dart/element/element.dart';
import 'package:theme_tailor/src/util/import_finder.dart';

extension LibraryElementExtension on LibraryElement {
  bool get hasFlutterDiagnosticableImport {
    return ImportFinder(
      lib: this,
      whereElement: isClass('Diagnosticable'),
      whereLibrary: isWithinLibrary('diagnostics'),
    ).recursiveSearch();
  }
}
