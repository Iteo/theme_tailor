import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/util/extension/scope_extension.dart';

extension ConstandReaderExtension on ConstantReader {
  T getFieldOrElse<T>(
    String name, {
    required T? Function(ConstantReader o) decode,
    required T Function() orElse,
  }) {
    final field = peek(name);
    if (field == null || field.isNull) return orElse();
    return decode(field) ?? orElse();
  }

  List<String>? toStringList() {
    return listValue.map((e) => e.toStringValue()).nonNulls.toList();
  }

  E? toEnum<E extends Enum>(E? Function(String name) fromName) {
    return revive().accessor.split('.').last.let(fromName);
  }
}
