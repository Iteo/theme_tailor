import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../util/message.dart';

class ThemeTailorGenerator extends GeneratorForAnnotation<Tailor> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement || element is Enum) {
      throw InvalidGenerationSourceError(
          Message.unsupportedAnnotationTarget(element),
          element: element);
    }

    final strBuffer = StringBuffer();

    /// DEBUG PLAYGROUND
    final parsedLibResult = element.session!
        .getParsedLibraryByElement(element.library) as ParsedLibraryResult;
    final elDeclarationResult = parsedLibResult.getElementDeclaration(element)!;

    final tailorAnnotation =
        elDeclarationResult.node.childEntities.first as Annotation;
    final tailorProps =
        (tailorAnnotation.arguments!.arguments[0] as ListLiteral)
            .elements
            .whereType<MethodInvocation>();

    annotation.read('props').listValue.forEachIndexed((i, propValues) {
      for (final variable in propValues.getField('values')!.toListValue()!) {
        final type = variable.type;
        strBuffer.writeln(commented('$type ${variable.toString()}'));
      }

      final tailorProp = tailorProps.elementAt(i);
      final tailorPropEncoder = tailorProp.argumentList.arguments
          .whereType<NamedExpression>()
          .firstWhereOrNull((element) => element.name.label.name == 'encoder');

      // TODO this won't work if it is a SimpleIdentifierImpl
      // final tailorPropEncoderType = (tailorPropEncoder?.expression as MethodInvocation?)?.methodName;

      strBuffer.writeln(commented(
          'encoder: ${tailorPropEncoder?.expression ?? 'No encoder'}'));
      // ..writeln(commented('encoderType: $tailorPropEncoderType'));
    });

    return strBuffer.toString();
    // final config = ThemeExtensionConfig.fromData(element, annotation);
    // final template = ThemeExtensionClassTemplate(config);
    // return template.generate();
  }
}

String commented(String val) => '/// $val';
