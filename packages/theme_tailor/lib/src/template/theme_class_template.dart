import 'package:collection/collection.dart';

import 'package:theme_tailor/src/model/theme_class_config.dart';
import 'package:theme_tailor/src/template/dart_type_nullable_template.dart';

class ThemeClassTemplate {
  const ThemeClassTemplate(this.config);

  final ThemeClassConfig config;

  String _constructorAndParams() {
    final constructorBuffer = StringBuffer();
    final fieldsBuffer = StringBuffer();

    config.fields.forEach((key, value) {
      constructorBuffer.write('required this.$key,');
      fieldsBuffer.write('final ${value.typeStr} $key;');
    });

    return '''
    ${config.returnType}({
      ${constructorBuffer.toString()}
    });
    
    ${fieldsBuffer.toString()}
    ''';
  }

  /// Generate all of the themes
  String _generateThemes() {
    if (config.themes.isEmpty) return '';
    final buffer = StringBuffer();
    config.themes.forEachIndexed((i, e) {
      buffer.write(_themeTemplate(i, e, config.fields.keys.toList()));
    });
    return buffer.toString();
  }

  /// Template for one static theme
  String _themeTemplate(int index, String themeName, List<String> props) {
    final buffer = StringBuffer();
    final returnType = config.returnType;

    for (final prop in props) {
      buffer.write('$prop: ${config.baseClassName}.$prop[$index],');
    }

    return '''
    static final $returnType $themeName = $returnType(
      ${buffer.toString()}
    );\n
    ''';
  }

  String _copyWithMethod() {
    final returnType = config.returnType;
    final methodParams = StringBuffer();
    final classParams = StringBuffer();

    config.fields.forEach((key, value) {
      methodParams.write('${NullableTypeTemplate(value.typeStr)} $key,');
      classParams.write('$key: $key ?? this.$key,');
    });

    return '''
    @override
    $returnType copyWith({
      ${methodParams.toString()}
    }) {
      return $returnType(
        ${classParams.toString()}
      );
    }
    ''';
  }

  String _lerpMethod() {
    final returnType = config.returnType;
    final classParams = StringBuffer();

    config.fields.forEach((key, value) {
      classParams.write(
          '$key: ${config.encoderDataManager.encoderFromField(value).callLerp(key, 'other.$key', 't')},');
    });

    return '''
    @override
    $returnType lerp(ThemeExtension<$returnType>? other, double t) {
      if (other is! $returnType) return this;
      return $returnType(
        ${classParams.toString()}
      );
    }
    ''';
  }

  @override
  String toString() {
    return '''
    class ${config.returnType} extends ThemeExtension<${config.returnType}>{
      ${_constructorAndParams()}
      ${_generateThemes()}
      ${_copyWithMethod()}
      ${_lerpMethod()}
    }
    ''';
  }
}
