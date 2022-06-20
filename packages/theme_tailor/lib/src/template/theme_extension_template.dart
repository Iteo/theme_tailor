import 'package:theme_tailor/src/model/theme_class_config.dart';
import 'package:theme_tailor/src/template/extension_template.dart';
import 'package:theme_tailor/src/template/getter_template.dart';
import 'package:theme_tailor/src/util/extension/scope_extension.dart';
import 'package:theme_tailor/src/util/string_format.dart';

class ThemeExtensionTemplate {
  const ThemeExtensionTemplate(this.config, this.fmt);

  final ThemeClassConfig config;
  final StringFormat fmt;

  @override
  String toString() {
    final extension = config.themeGetter;

    if (!extension.shouldGenerate) return '';

    final extensionBody = StringBuffer();

    final extensionName = '${config.returnType}${config.themeGetter.shortName}';
    final themeGetterName = fmt
        .typeAsVariableName(config.returnType, 'Theme')
        .also((it) => extension.hasPublicThemeGetter ? it : fmt.asPrivate(it));

    extensionBody.write(GetterTemplate(
      type: config.returnType,
      name: themeGetterName,
      accessor: extension.target.themeExtensionAccessor(config.returnType),
    ));

    if (extension.hasGeneratedProps) {
      for (final prop in config.fields.entries) {
        extensionBody.write(GetterTemplate(
          type: prop.value.typeName,
          name: prop.key,
          accessor: '$themeGetterName.${prop.key}',
        ));
      }
    }

    return ExtensionTemplate(
      content: extensionBody.toString(),
      name: extensionName,
      target: extension.target.name,
    ).toString();
  }
}
