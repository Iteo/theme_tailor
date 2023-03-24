import 'package:analyzer/dart/element/element.dart';
import 'package:theme_tailor/src/util/recursive_import_locator.dart';

/// TODO(rongix): refactor it to not return all elements (unnecessary)
extension LibraryElementExtension on LibraryElement {
  bool get hasFlutterDiagnosticableImport {
    return findAllAvailableTopLevelElements().any((element) {
      return element.name == 'DiagnosticableTreeMixin' &&
          (element.library?.isFromPackage('flutter') ?? false);
    });
  }
}
