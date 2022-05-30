import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../../theme_tailor.dart';
import '../util/message.dart';

class ThemeTailorGenerator extends GeneratorForAnnotation<Tailor> {
  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement || element is Enum) {
      throw InvalidGenerationSourceError(Message.unsupportedAnnotationTarget(element), element: element);
    }

    final strBuffer = StringBuffer()..writeln(commented('DEBUG PRINT:'));

    /// DEBUG PLAYGROUND
    final parsedLibResult = element.session!.getParsedLibraryByElement(element.library) as ParsedLibraryResult;
    final elDeclarationResult = parsedLibResult.getElementDeclaration(element)!;

    final tailorAnnotation = elDeclarationResult.node.childEntities.first as Annotation;
    final tailorProps =
        (tailorAnnotation.arguments!.arguments[0] as ListLiteral).elements.whereType<MethodInvocation>();

    annotation.read('props').listValue.forEachIndexed((i, propValues) {
      final tailorProp = tailorProps.elementAt(i);

      final name = propValues.getField('name')!.toStringValue();
      const nameType = String;

      /// Values expression (as it is typed in the annotation)
      final values = tailorProp.argumentList.arguments.elementAt(1);
      final valuesTypes = propValues.getField('values')!.toListValue()!.map((e) => e.type);

      /// Encoder expression (as it is typed in the annotation)
      final encoder = tailorProp.argumentList.arguments
          .whereType<NamedExpression>()
          .firstWhereOrNull((element) => element.name.label.name == 'encoder')
          ?.expression;
      final encoderType = propValues.getField('encoder')?.type;

      strBuffer
        ..writeln(commented('name: $name | type: $nameType'))
        ..writeln(commented('values: $values | type: $valuesTypes'))
        ..writeln(commented('encoder: ${encoder ?? '-'} | type: $encoderType'));

      // This won't work if it is a SimpleIdentifierImpl
      // final tailorPropEncoderType = (tailorPropEncoder?.expression as MethodInvocation?)?.methodName;

      // ..writeln(commented('encoderType: $tailorPropEncoderType'));
    });

    strBuffer.toString();
    final config = ThemeExtensionConfig.fromData(element, annotation);
    final template = ThemeExtensionClassTemplate(config);
    return template.generate();
  }
}

String commented(String val) => '/// $val';
