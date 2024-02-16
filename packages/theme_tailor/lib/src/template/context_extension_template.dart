import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_getter_data.dart';
import 'package:theme_tailor/src/template/getter_template.dart';
import 'package:theme_tailor/src/template/template.dart';
import 'package:theme_tailor/src/util/extension/scope_extension.dart';
import 'package:theme_tailor/src/util/string_format.dart';

class ContextExtensionTemplate extends Template {
  const ContextExtensionTemplate(
    this.className,
    this.extensionData,
    this.fields,
    this.themeClassName,
    this.themeDataClassName,
  );

  final String className;
  final String themeClassName;
  final String? themeDataClassName;
  final ExtensionData extensionData;
  final List<Field> fields;

  String get extensionTarget => themeDataClassName ?? extensionData.target.name;

  @override
  void write(StringBuffer buffer) {
    const fmt = StringFormat();

    if (!extensionData.shouldGenerate) return;

    final themeAccessor = fmt
        .typeAsVariableName(className, themeClassName)
        .also((it) => extensionData.hasPublicThemeGetter ? it : fmt.asPrivate(it));

    buffer
      ..writeln('extension $className${extensionData.shortName}')
      ..write(' on $extensionTarget {')
      ..write(
        GetterTemplate(
          type: className,
          name: themeAccessor,
          accessor: extensionData.target.themeExtensionAccessor(
            type: className,
            themeClassName: themeClassName,
          ),
        ),
      );

    if (extensionData.hasGeneratedProps) {
      for (final field in fields) {
        buffer.write(
          GetterTemplate(
            type: field.type,
            name: field.name,
            accessor: '$themeAccessor.${field.name}',
            documentationComment: field.documentation,
          ),
        );
      }
    }

    buffer.writeln('}');
  }
}
