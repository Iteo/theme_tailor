import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/template/template.dart';
import 'package:theme_tailor/src/template/theme_extension/copy_with_template.dart';
import 'package:theme_tailor/src/template/theme_extension/debug_fill_properties_template.dart';
import 'package:theme_tailor/src/template/theme_extension/equality_template.dart';
import 'package:theme_tailor/src/template/theme_extension/lerp_template.dart';

class TailorMixinTemplate extends Template {
  const TailorMixinTemplate(
    this.name,
    this.fields,
    this.encoderManager,
    this.hasDiagnosticableMixin,
  );

  final String name;
  final List<Field> fields;
  final ThemeEncoderManager encoderManager;
  final bool hasDiagnosticableMixin;

  @override
  void write(StringBuffer buffer) {
    buffer
      ..writeln('mixin _\$${name}TailorMixin on ThemeExtension<$name>')
      ..write(hasDiagnosticableMixin ? ',DiagnosticableTreeMixin {' : '{')
      ..template(_TailorMixinFieldGettersTemplate(fields))
      ..template(CopyWithTemplate(name, fields))
      ..template(LerpTemplate(name, fields, encoderManager))
      ..template(EqualityTemplate(name, fields));

    if (hasDiagnosticableMixin) {
      buffer.template(DebugFillPropertiesTemplate(name, fields));
    }

    buffer.writeln('}');
  }
}

class _TailorMixinFieldGettersTemplate extends Template {
  const _TailorMixinFieldGettersTemplate(this.fields);

  final List<Field> fields;

  @override
  void write(StringBuffer buffer) {
    buffer.writeAll(fields.map((e) => '${e.type} get ${e.name};'));
  }
}
