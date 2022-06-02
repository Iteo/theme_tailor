// // ignore_for_file: prefer_interpolation_to_compose_strings

// import 'package:collection/collection.dart';

// import '../model/theme_extension_config.dart';
// import 'dart_type_nullable_template.dart';
// import 'template.dart';

// class ThemeExtensionClassTemplate extends Template {
//   const ThemeExtensionClassTemplate(this.config);

//   final ThemeExtensionConfig config;

//   @override
//   String generate() {
//     return '''
//     class ${config.className} extends ThemeExtension<${config.className}>{
//       ${_generateConstructor()}

//       ${_generateFields()}

//       ${_generateStaticThemes()}

//       ${_generateMethodCopyWith()}

//       ${_generateMethodLerp()}
//     }
//     ''';
//   }

//   String _generateConstructor() {
//     final fields = config.fields.map((e) => 'required this.${e.name},').join();
//     return 'const ${config.className}({$fields});';
//   }

//   String _generateFields() {
//     return config.fields.map((field) => 'final ${field.valuesType.first ?? 'dynamic'} ${field.name};').join();
//   }

//   String _generateStaticThemes() {
//     return config.themeNames.mapIndexed((i, e) => _generateStaticTheme(i)).join('\n');
//   }

//   String _generateStaticTheme(int i) {
//     final fields = config.fields.map((field) => '${field.name}: ${field.values.elementAt(i)},').join();

//     return '''
//     static const ${config.className} ${config.themeNames.elementAt(i)} = ${config.className}(
//       $fields
//     );
//     ''';
//   }

//   String _generateMethodCopyWith() {
//     final params = config.fields.map((e) => '${DartTypeNullableTemplate(e.type).generate()} ${e.name},').join();
//     final fields = config.fields.map((e) => '${e.name}: ${e.name} ?? this.${e.name},').join();
//     return '''
//     @override
//     ThemeExtension<${config.className}> copyWith({$params}){
//       return ${config.className}($fields);
//     }
//     ''';
//   }

//   String _generateMethodLerp() {
//     const simpleLerp = 'T simpleLerp<T>(T a, T b, double t) => t < .5 ? a : b;';
//     final lerpFunctions = [simpleLerp].join();

//     final fields = config.fields.map((e) => '${e.name}: simpleLerp(${e.name}, other.${e.name}, t),').join();

//     return '''
//     @override
//     ThemeExtension<${config.className}> lerp(other, t) {
//     if (other is! ${config.className}) return this;
//     return ${config.className}($fields);
//     }
//     $lerpFunctions
//     ''';
//   }
// }
