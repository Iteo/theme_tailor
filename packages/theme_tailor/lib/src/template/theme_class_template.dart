import 'package:collection/collection.dart';
import 'package:theme_tailor/src/model/theme_class_config.dart';
import 'package:theme_tailor/src/template/template.dart';
import 'package:theme_tailor/src/template/theme_extension/copy_with_template.dart';
import 'package:theme_tailor/src/template/theme_extension/debug_fill_properties_template.dart';
import 'package:theme_tailor/src/template/theme_extension/equality_template.dart';
import 'package:theme_tailor/src/template/theme_extension/lerp_template.dart';
import 'package:theme_tailor/src/util/string_format.dart';

class ThemeTailorTemplate extends Template {
  const ThemeTailorTemplate(this.config, this.fmt);

  final ThemeClassConfig config;
  final StringFormat fmt;

  String _classTypesDeclaration() {
    final mixins = [
      if (config.hasDiagnosticableMixin) 'DiagnosticableTreeMixin'
    ];
    final mixinsString = mixins.isEmpty ? '' : ' with ${mixins.join(',')}';

    return 'extends ThemeExtension<${config.className}>$mixinsString';
  }

  String _constructorAndParams() {
    final constructorBuffer = StringBuffer();
    final fieldsBuffer = StringBuffer();

    config.fields.forEach((key, value) {
      if (!value.isNullable) {
        constructorBuffer.write('required ');
      }
      constructorBuffer.write('this.$key,');
      fieldsBuffer
        ..write(config.annotationManager.expandFieldAnnotations(key))
        ..write(
          value.documentation != null ? '${value.documentation}\n' : '',
        )
        ..write('final ${value.type} $key;');
    });

    if (config.fields.isEmpty) {
      return '''
      const ${config.className}();
    
      ${fieldsBuffer.toString()}
    ''';
    } else {
      return '''
      const ${config.className}({
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
    if (config.staticGetters && !config.constantThemes) {
      config.themes.forEachIndexed((_, e) {
        buffer.write(_getterTemplate(e));
      });
    }
    config.themes.forEachIndexed((i, e) {
      buffer.write(_themeTemplate(i, e));
    });
    final themesList = config.themes.fold('', (p, theme) => '$p$theme,');
    buffer.writeln(
        'static ${_themeModifier()} ${config.themesFieldName} = [$themesList];');
    return buffer.toString();
  }

  /// Template for one static getter
  String _getterTemplate(String themeName) {
    final returnType = config.className;

    return '''static $returnType get $themeName => kDebugMode ? _${themeName}Getter : _${themeName}Final;
    \n''';
  }

  /// Template for one static theme
  String _themeTemplate(int index, String themeName) {
    final buffer = StringBuffer();
    final returnType = config.className;

    for (final field in config.fields.entries) {
      final values = field.value.values;
      if (values != null) {
        buffer.write('${field.key}: ${values[index]},');
      } else {
        buffer.write(
            '${field.key}: ${config.baseClassName}.${field.key}[$index],');
      }
    }

    if (config.constantThemes || !config.staticGetters) {
      return '''
    static ${_themeModifier()} $returnType $themeName = $returnType(
      ${buffer.toString()}
    );\n
    ''';
    }
    return '''
    static $returnType get _${themeName}Getter => $returnType(
      ${buffer.toString()}
    );\n    
    static final $returnType _${themeName}Final = $returnType(
      ${buffer.toString()}
    );\n
    ''';
  }

  String _fromJsonFactory() {
    if (!config.hasJsonSerializable) return '';
    return '''factory ${config.className}.fromJson(Map<String, dynamic> json) =>
      _\$${config.className}FromJson(json);\n''';
  }

  String _themeModifier() => config.constantThemes ? 'const' : 'final';

  @override
  void write(StringBuffer buffer) {
    final fields = config.fields.values.toList();

    buffer
      ..writeln(config.annotationManager.expandClassAnnotations())
      ..writeln('class ${config.className} ${_classTypesDeclaration()} {')
      ..writeln(_constructorAndParams())
      ..writeln(_fromJsonFactory())
      ..writeln(_generateThemes())
      ..template(CopyWithTemplate(config.className, fields))
      ..template(LerpTemplate(config.className, fields, config.encoderManager));

    if (config.hasDiagnosticableMixin) {
      buffer.template(DebugFillPropertiesTemplate(config.className, fields));
    }

    buffer
      ..template(EqualityTemplate(config.className, fields))
      ..writeln('}');
  }
}
