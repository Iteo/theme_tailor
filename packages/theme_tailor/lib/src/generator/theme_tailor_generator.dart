import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../../theme_tailor.dart';
import '../util/message.dart';
import '../util/string_format.dart';

class ThemeTailorGenerator extends GeneratorForAnnotation<Tailor> {
  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement || element is Enum) {
      throw InvalidGenerationSourceError(Message.unsupportedAnnotationTarget(element), element: element);
    }

    /// TODO:
    /// class name +
    /// properties names +
    /// properties output types +
    /// properties values (literals)
    /// properties custom lerp
    /// properties custom encoding (class != const)

    final className = element.displayName.formatClassName();
    final themeNames = annotation.read('themes').listValue.map((e) => e.toSymbolValue());
    final propertiesMap = annotation.read('props').mapValue;

    final properties = <String>[];
    final types = <String>[];

    final typeDeclaration = RegExp(r'<(.*?)>');

    for (final e in propertiesMap.entries) {
      final property = e.key?.toStringValue();

      final declaration = e.value!.type!.element!.declaration!.toString();
      print(declaration);

      final type = typeDeclaration.firstMatch(declaration)!.group(1)?.split(',').last.trim();

      if (property == null) InvalidGenerationSourceError('Bad property name on the $element', element: element);
      if (type == null) InvalidGenerationSourceError('Can not determine type for the property: $property');

      properties.add(property!);
      types.add(type!);
    }

    final strBuffer = StringBuffer()
      ..writeln(commented('DEBUG PRINT:'))
      ..writeln(commented('class name: $className'))
      ..writeln(commented('themes: $themeNames'));

    /// AST NODE
    final classAnnotation =
        getAstNodeFromElement(element).childEntities.firstWhere((e) => e is Annotation) as Annotation;
    final annotationArgs = classAnnotation.arguments?.arguments;
    final isAnnotationArgsEmpty = annotationArgs?.isEmpty ?? true;

    return '${strBuffer.toString()}\n\n}';

    // print('Annotation len: $annotationArgsLen');

    // final annotationHasProps = annotationArgsLen > 0;

    // final tailorProps = (annotationArgs?.first as ListLiteral).elements.whereType<MethodInvocation>();

    // print('tailorProps - ok');

    // final themeExtensionFields = <ThemeExtensionField>[];

    // annotation.read('props').listValue.forEachIndexed((i, propValues) {
    //   final tailorProp = tailorProps.elementAt(i);

    //   final name = propValues.getField('name')!.toStringValue()!;

    //   /// Encoder expression (as it is typed in the annotation)
    //   // final encoder = tailorProp.argumentList.arguments
    //   //     .whereType<NamedExpression>()
    //   //     .firstWhereOrNull((element) => element.name.label.name == 'encoder')
    //   //     ?.expression;
    //   // final encoderType = propValues.getField('encoder')?.type;

    //   /// Values expression (as it is typed in the annotation)
    //   final values = (tailorProp.argumentList.arguments.elementAt(1) as ListLiteral).elements;
    //   final valuesTypes = propValues.getField('values')!.toListValue()!.map((e) => e.type);

    //   strBuffer
    //     ..writeln(commented('name: $name'))
    //     // ..writeln(commented('encoder: ${encoder ?? '-'} | type: $encoderType'))
    //     ..writeln(commented('values: $values | type: $valuesTypes'));

    //   themeExtensionFields.add(ThemeExtensionField(name, []));

    //   // This won't work if it is a SimpleIdentifierImpl
    //   // final tailorPropEncoderType = (tailorPropEncoder?.expression as MethodInvocation?)?.methodName;

    //   // ..writeln(commented('encoderType: $tailorPropEncoderType'));
    // });

    // final config = ThemeExtensionConfig.fromData(className, themeNames, themeExtensionFields);
    // final template = ThemeExtensionClassTemplate(config);
  }
}

String commented(String val) => '/// $val';

AstNode getAstNodeFromElement(Element element) {
  final session = element.session!;
  final parsedLibResult = session.getParsedLibraryByElement(element.library!) as ParsedLibraryResult;
  final elDeclarationResult = parsedLibResult.getElementDeclaration(element)!;
  return elDeclarationResult.node;
}
