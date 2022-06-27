import 'package:collection/collection.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_class_config.dart';
import 'package:theme_tailor/src/util/string_format.dart';

class ThemeClassTemplate {
  const ThemeClassTemplate(this.config, this.fmt);

  final ThemeClassConfig config;
  final StringFormat fmt;

  String _classTypesDeclaration() {
    final mixins = [
      if (config.isFlutterDiagnosticable) 'DiagnosticableTreeMixin'
    ];
    final mixinsString = mixins.isEmpty ? '' : ' with ${mixins.join(',')}';

    return 'extends ThemeExtension<${config.className}>$mixinsString';
  }

  String _constructorAndParams() {
    final constructorBuffer = StringBuffer();
    final fieldsBuffer = StringBuffer();

    config.fields.forEach((key, value) {
      constructorBuffer.write('required this.$key,');
      fieldsBuffer
        ..write(config.annotationManager.expandFieldAnnotations(key))
        ..write('final ${value.typeName} $key;');
    });

    if (config.fields.isEmpty) {
      return fieldsBuffer.toString();
    } else {
      return '''
      ${config.className}({
        ${constructorBuffer.toString()}
      });
    
      ${fieldsBuffer.toString()}
    ''';
    }
  }

  /// Generate all of the themes
  String _generateThemes() {
    if (config.themes.isEmpty) return '';
    final buffer = StringBuffer();
    config.themes.forEachIndexed((i, e) {
      buffer.write(_themeTemplate(i, e, config.fields.keys.toList()));
    });
    final themesList = config.themes.fold('', (p, theme) => '$p$theme,');
    buffer.writeln('static final themes = [$themesList];');
    return buffer.toString();
  }

  /// Template for one static theme
  String _themeTemplate(int index, String themeName, List<String> props) {
    final buffer = StringBuffer();
    final returnType = config.className;

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
    final returnType = config.className;
    if (config.fields.isEmpty) {
      return '''
      @override
      ThemeExtension<$returnType> copyWith() => $returnType();
      ''';
    }

    final methodParams = StringBuffer();
    final classParams = StringBuffer();

    config.fields.forEach((key, value) {
      methodParams.write('${fmt.asNullableType(value.typeName)} $key,');
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
    final returnType = config.className;
    final classParams = StringBuffer();
    config.fields.forEach((key, value) {
      if (value.implementsThemeExtension) {
        classParams.write('$key: $key.lerp(other.$key,t),');
      } else {
        classParams.write(
            '$key: ${config.encoderManager.encoderFromField(value).callLerp(key, 'other.$key', 't')},');
      }
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

  String _fromJsonFactory() {
    if (!config.annotationManager.hasJsonSerializable) return '';
    return '''factory ${config.className}.fromJson(Map<String, dynamic> json) =>
      _\$${config.className}FromJson(json);\n''';
  }

  String _debugFillPropertiesMethod() {
    if (!config.isFlutterDiagnosticable) return '';

    final diagnostics = [
      for (final e in config.fields.entries)
        "..add(DiagnosticsProperty('${e.key}', ${e.key}))",
    ].join();

    return '''
    @override
    void debugFillProperties(DiagnosticPropertiesBuilder properties) {
      super.debugFillProperties(properties);
      properties
        ..add(DiagnosticsProperty('type', '${config.className}'))
        $diagnostics;
    }
    ''';
  }

  String _equalOperator() {
    String equality(Field field) {
      final name = field.name;
      return 'const DeepCollectionEquality().equals($name, other.$name)';
    }

    final comparisons = [
      'other.runtimeType == runtimeType',
      'other is ${config.className}',
      for (final field in config.fields.values) equality(field)
    ];

    return '''@override bool operator ==(Object other) {
      return identical(this, other) || (${comparisons.join('&&')});
    }
    ''';
  }

  String _hashCodeMethod() {
    String hashMethod(String val) => '@override int get hashCode{return $val;}';
    String hash(Field field) =>
        'const DeepCollectionEquality().hash(${field.name})';

    final hashedProps = [
      'runtimeType',
      for (final field in config.fields.values) hash(field)
    ];

    if (hashedProps.length == 1)
      return hashMethod('${hashedProps.first}.hashCode');

    if (hashedProps.length <= 20)
      return hashMethod('Object.hash(${hashedProps.join(',')})');

    return hashMethod('Object.hashAll([${hashedProps.join(',')}])');
  }

  @override
  String toString() {
    return '''
    ${config.annotationManager.expandClassAnnotations()}
    class ${config.className} ${_classTypesDeclaration()} {
      ${_constructorAndParams()}
      ${_fromJsonFactory()}
      ${_generateThemes()}
      ${_copyWithMethod()}
      ${_lerpMethod()}
      ${_debugFillPropertiesMethod()}
      ${_equalOperator()}
      ${_hashCodeMethod()}
    }
    ''';
  }
}
