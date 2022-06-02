// import 'dart:collection';

// import 'template.dart';

// // class ThemeExtensionClassTemplate extends Template {
// //   const ThemeExtensionClassTemplate(
// //     this.className,
// //     this.isConst,
// //     this.constructorParams,
// //     this.fields,
// //     this.themes,
// //   );

// //   final String className;
// //   final bool isConst;
// //   final List<String> constructorParams;
// //   final List<String> fields;
// //   final SplayTreeMap<String, SplayTreeMap<String, String>> themes;

// //   /// Generate all of the themes
// //   String generateThemes() {
// //     if (themes.isEmpty) return '';
// //     final buffer = StringBuffer();
// //     themes.forEach((key, value) => buffer.write(themeTemplate(key, value)));
// //     return buffer.toString();
// //   }

// //   /// Template for one static theme
// //   String themeTemplate(String name, SplayTreeMap<String, String> propsAndValues) {
// //     final buffer = StringBuffer();

// //     propsAndValues.forEach((key, value) => buffer.write('$key: $value'));

// //     return '''
// //     ${'static ${isConst ? 'const' : ''} $className $name = $className('}
// //       ${buffer.toString()}
// //     );
// //     ''';
// //   }

// //   @override
// //   String generate() {
// //     return '''
// //     class $className extends ThemeExtension<$className> {
// //       const $className({
// //         $constructorParams
// //       });

// //       $fields

// //       ${generateThemes()}

// //       @override
// //       ThemeExtension<$className> copyWith({
// //         SuperThemeEnum? themeType,
// //         SuperThemeEnum? themeType2,
// //       }) {
// //         return $className(
// //           themeType: themeType ?? this.themeType,
// //           themeType2: themeType2 ?? this.themeType2,
// //         );
// //       }

// //       @override
// //       ThemeExtension<$className> lerp(other, t) {
// //         if (other is! $className) return this;
// //         return $className(
// //           themeType: simpleLerp(themeType, other.themeType, t),
// //           themeType2: simpleLerp(themeType2, other.themeType2, t),
// //         );
// //       }

// //       T _simpleLerp<T>(T a, T b, double t) => t < .5 ? a : b;
// //   }
// //   ''';
// //   }
// // }

// class ThemeExtensionClassTemplate2 extends Template {
//   const ThemeExtensionClassTemplate2(
//     this.className,
//     this.isConst,
//     this.params,
//     this.themes,
//   );

//   final String className;
//   final bool isConst;
//   final List<ParameterModel> params;
//   final SplayTreeMap<String, ParameterModel> themes;

//   /// Generate all of the themes
//   String generateThemes() {
//     if (themes.isEmpty) return '';
//     final buffer = StringBuffer();
//     themes.forEach((key, value) => buffer.write(themeTemplate(key, value)));
//     return buffer.toString();
//   }

//   /// Template for one static theme
//   String themeTemplate(String name, SplayTreeMap<String, String> propsAndValues) {
//     final buffer = StringBuffer();

//     propsAndValues.forEach((key, value) => buffer.write('$key: $value'));

//     return '''
//     ${'static ${isConst ? 'const' : ''} $className $name = $className('}
//       ${buffer.toString()}
//     );
//     ''';
//   }

//   String constructorParams() {
//     return '';
//   }

//   @override
//   String generate() {
//     return '''
//     class $className extends ThemeExtension<$className> {
//       ${params.toConstructorAndFields(className, isConst)}

//       ${generateThemes()}

//       @override
//       ThemeExtension<$className> copyWith({
//         SuperThemeEnum? themeType,
//         SuperThemeEnum? themeType2,
//       }) {
//         return $className(
//           themeType: themeType ?? this.themeType,
//           themeType2: themeType2 ?? this.themeType2,
//         );
//       }

//       @override
//       ThemeExtension<$className> lerp(other, t) {
//         if (other is! $className) return this;
//         return $className(
//           themeType: simpleLerp(themeType, other.themeType, t),
//           themeType2: simpleLerp(themeType2, other.themeType2, t),
//         );
//       }

//       T _simpleLerp<T>(T a, T b, double t) => t < .5 ? a : b;
//   }
//   ''';
//   }
// }

extension ParameterModelIterableExtension on Iterable<ParameterModel> {
  String toConstructorAndFields(String className, bool isConst) {
    final positionalParams = <ParameterModel>[];
    final namedParams = <ParameterModel>[];

    forEach((e) => e.isNamed ? namedParams.add(e) : positionalParams.add(e));

    final params = [
      if (positionalParams.isNotEmpty) ...positionalParams.map((e) => e.toConstructorParameter(isRequired: false)),
      if (namedParams.isNotEmpty) '{${namedParams.map((e) => e.toConstructorParameter(isRequired: false)).join()}}',
    ].join();

    final members = [
      if (positionalParams.isNotEmpty)
        ...positionalParams.map((e) => e.toClassMember(ifFinal: isConst ? isConst : e.isFinal)),
      if (namedParams.isNotEmpty) ...namedParams.map((e) => e.toClassMember(ifFinal: isConst ? isConst : e.isFinal)),
    ].join();

    return '''
    ${isConst ? 'const ' : ''}class $className(
      $params
    );
    $members
    ''';
  }
}

class ParameterModel {
  const ParameterModel(
    this.type,
    this.name,
    this.isNamed,
    this.isFinal,
  );

  final TypeModel type;
  final String name;
  final bool isNamed;
  final bool isFinal;

  String toConstructorParameter({bool isRequired = true}) {
    return '${isRequired ? 'required ' : ''}this.$name,';
  }

  String toClassMember({bool ifFinal = true}) {
    return '${ifFinal ? 'final ' : ''}$type $name;';
  }

  String toMethodParameter({bool isNullable = false}) {
    return '${isNullable ? type.asNullable : ''} $name';
  }
}

class ValueModel<T> {
  const ValueModel({
    required this.type,
    this.value,
  });

  final TypeModel type;
  final T? value;
}

class TypeModel {
  const TypeModel(this._rawType);

  final String _rawType;

  bool get isNullable => _rawType.endsWith('?') || _rawType == 'dynamic';

  String get asNullable => isNullable ? _rawType : '$_rawType?';
  String get asNonNullable => _rawType == 'dynamic' ? _rawType : _rawType.replaceAll('?', '');
}
