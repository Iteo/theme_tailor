import 'package:analyzer/dart/constant/value.dart';
import 'package:theme_tailor/src/util/extension/scope_extension.dart';

extension DartObjectExtension on DartObject {
  T getFieldOrElse<T>(
    String name, {
    required T? Function(DartObject o) decode,
    required T Function() orElse,
  }) {
    final field = getField(name);
    if (field == null || field.isNull) return orElse();
    return decode(field) ?? orElse();
  }

  List<String>? toStringList() {
    return toListValue()?.map((e) => e.toStringValue()).nonNulls.toList();
  }

  E? toEnum<E extends Enum>(E? Function(String name) fromName) {
    return toStringValue()?.split('.').last.let(fromName);
  }
}
