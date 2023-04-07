import 'package:analyzer/dart/element/element.dart';
import 'package:theme_tailor/src/util/extension/element_extension.dart';
import 'package:theme_tailor/src/util/recursive_import_locator.dart';

extension LibraryElementExtension on LibraryElement {
  bool get hasFlutterDiagnosticableImport {
    return allVisibleElements().any((element) =>
        element.name == 'DiagnosticableTreeMixin' &&
        element.isFromPackage('flutter'));
  }
}
