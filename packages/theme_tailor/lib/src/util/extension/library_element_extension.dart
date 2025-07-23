import 'package:analyzer/dart/element/element2.dart';
import 'package:theme_tailor/src/util/recursive_import_locator.dart';

extension LibraryElementExtension on LibraryElement2 {
  bool get hasFlutterDiagnosticableImport {
    return findAllAvailableTopLevelElements().any((element) {
      return element.name3 == 'DiagnosticableTreeMixin' && (element.library2?.isFromPackage('flutter') ?? false);
    });
  }
}
