import 'package:theme_tailor/src/model/theme_class_config.dart';
import 'package:theme_tailor/src/template/template.dart';
import 'package:theme_tailor/src/util/extensions.dart';
import 'package:theme_tailor/src/util/string_format.dart';

class ThemeExtensionTemplate {
  const ThemeExtensionTemplate(this.config, this.fmt);

  final ThemeClassConfig config;
  final StringFormat fmt;

  void writeBuffer(StringBuffer main) {
    final extension = config.themeGetter;

    if (!extension.shouldGenerate) return;

    final extensionBody = StringBuffer();

    final extensionName = '${config.returnType}${config.themeGetter.shortName}';
    final themeGetterName = fmt
        .typeAsVariableName(config.returnType, 'Theme')
        .also((it) => extension.hasPublicThemeGetter ? it : fmt.asPrivate(it));

    Template.getter(
      writer: extensionBody,
      type: config.returnType,
      name: themeGetterName,
      accessor: extension.target.themeExtensionAccessor(config.returnType),
    );

    if (extension.hasGeneratedProps) {
      for (final prop in config.fields.entries) {
        Template.getter(
          writer: extensionBody,
          type: prop.value.typeStr,
          name: prop.key,
          accessor: '$themeGetterName.${prop.key}',
        );
      }
    }

    Template.extension(
      writer: main,
      contentBuffer: extensionBody,
      name: extensionName,
      target: extension.target.name,
    );
  }
}
