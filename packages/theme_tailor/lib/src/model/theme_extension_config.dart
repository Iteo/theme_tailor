import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import '../util/string_format.dart';

class ThemeExtensionConfig {
  const ThemeExtensionConfig(
    this.className,
    this.themeNames,
    this.fields,
  );

  factory ThemeExtensionConfig.fromData(
      ClassElement element, ConstantReader annotation) {
    final name = element.displayName.formatClassName();
    final themeNames = annotation
        .read('themes')
        .listValue
        .map((e) => e.toString())
        .toList(growable: false);

    final props = annotation
        .read('props')
        .listValue
        .map(ThemeExtensionField.fromDartObject);

    return ThemeExtensionConfig(name, themeNames, props);
  }

  final String className;
  final Iterable<String> themeNames;
  final Iterable<ThemeExtensionField> fields;
}

class ThemeExtensionField {
  const ThemeExtensionField(
    this.name,
    this.type,
    this.values,
  );

  factory ThemeExtensionField.fromDartObject(DartObject object) {
    final name = object.getField('name')!.toStringValue()!;
    final values = object.getField('values')!.toListValue()!;
    final type = values.first.type!.getDisplayString(withNullability: true);

    return ThemeExtensionField(name, type, values);
  }

  final String name;
  final String type;
  final Iterable<DartObject> values;
}
