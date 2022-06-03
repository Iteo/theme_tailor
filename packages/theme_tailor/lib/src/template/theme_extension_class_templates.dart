import 'package:collection/collection.dart';

import 'package:theme_tailor/src/model/theme_extension_config.dart';
import 'package:theme_tailor/src/template/dart_type_nullable_template.dart';

class ThemeExtensionClassTemplate {
  const ThemeExtensionClassTemplate(this.config);

  final ThemeExtensionClassConfig config;

  String _constructorAndParams() {
    final constructorBuffer = StringBuffer();
    final fieldsBuffer = StringBuffer();

    config.fields.forEach((key, value) {
      constructorBuffer.write('required this.$key,');
      fieldsBuffer.write('final $value $key;');
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

  String _lerpMethods() {
    const _simpleLerp = 'T _simpleLerp<T>(T a, T b, double t) => t < .5 ? a : b;';
    return _simpleLerp;
  }

  String _copyWithMethod() {
    final returnType = config.returnType;
    final methodParams = StringBuffer();
    final classParams = StringBuffer();

    config.fields.forEach((key, value) {
      methodParams.write('${NullableTypeTemplate(value)} $key,');
      classParams.write('$key: $key ?? this.$key,');
    });

    return '''
    @override
    ThemeExtension<$returnType> copyWith({
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
      classParams.write('$key: _simpleLerp($key, other.$key, t),');
    });

    return '''
    @override
    ThemeExtension<$returnType> lerp(other, t) {
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
      ${_lerpMethods()}
    }
    ''';
  }
}
