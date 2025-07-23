import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

const coreIterableTypeChecker = TypeChecker.fromUrl('dart:core#Iterable');

extension DartTypeExtension on DartType {
  DartType get coreIterableGenericType {
    return typeArgumentsOf(coreIterableTypeChecker)?.single ?? this;
  }

  bool get isThemeExtensionType {
    return typeImplementations.any(
      (e) => e.getDisplayString().startsWith('ThemeExtension'),
    );
  }
}
