import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
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

    final className = element.displayName.formatClassName();
    final themeNames = annotation.read('themes').listValue.map((e) => e.toStringValue()!);
    final defaultProps = annotation.read('props').listValue.map((e) => e.toString());

    print('DEFAULT PROPS VALUES: $defaultProps');

    final strBuffer = StringBuffer()
      ..writeln(commented('DEBUG PRINT:'))
      ..writeln(commented('class name: $className'))
      ..writeln(commented('themes: $themeNames'));

    /// DEBUG PLAYGROUND
    final parsedLibResult = element.session?.getParsedLibraryByElement(element.library) as ParsedLibraryResult;
    final elementDeclarationResult = parsedLibResult.getElementDeclaration(element)!;

    print('elementDeclaration - ok');

    final classAnnotation =
        elementDeclarationResult.node.childEntities.firstWhere((e) => e is Annotation) as Annotation;

    print('tailorAnnotation - ok');

    final annotationArgs = classAnnotation.arguments?.arguments;

    /// Handle empty annotation
    final isAnnotationArgsEmpty = annotationArgs?.isEmpty ?? true;
    final annotationArgsLen = isAnnotationArgsEmpty ? 0 : annotationArgs!.length;
    print('Annotation len: $annotationArgsLen');

    final annotationHasProps = annotationArgsLen > 0;

    final tailorProps = (annotationArgs?.first as ListLiteral).elements.whereType<MethodInvocation>();

    print('tailorProps - ok');

    final themeExtensionFields = <ThemeExtensionField>[];

    annotation.read('props').listValue.forEachIndexed((i, propValues) {
      final tailorProp = tailorProps.elementAt(i);

      final name = propValues.getField('name')!.toStringValue()!;

      /// Encoder expression (as it is typed in the annotation)
      final encoder = tailorProp.argumentList.arguments
          .whereType<NamedExpression>()
          .firstWhereOrNull((element) => element.name.label.name == 'encoder')
          ?.expression;
      final encoderType = propValues.getField('encoder')?.type;

      /// Values expression (as it is typed in the annotation)
      final values = (tailorProp.argumentList.arguments.elementAt(1) as ListLiteral).elements;
      final valuesTypes = propValues.getField('values')!.toListValue()!.map((e) => e.type);

      strBuffer
        ..writeln(commented('name: $name'))
        ..writeln(commented('encoder: ${encoder ?? '-'} | type: $encoderType'))
        ..writeln(commented('values: $values | type: $valuesTypes'));

      themeExtensionFields.add(ThemeExtensionField(name, values, valuesTypes, encoder, encoderType));

      // This won't work if it is a SimpleIdentifierImpl
      // final tailorPropEncoderType = (tailorPropEncoder?.expression as MethodInvocation?)?.methodName;

      // ..writeln(commented('encoderType: $tailorPropEncoderType'));
    });

    final config = ThemeExtensionConfig.fromData(className, themeNames, themeExtensionFields);
    final template = ThemeExtensionClassTemplate(config);
    return '${strBuffer.toString()}\n\n${template.generate()}';
  }
}

String commented(String val) => '/// $val';
