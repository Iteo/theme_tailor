import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

const themeEncoderChecker = TypeChecker.fromRuntime(ThemeEncoder);

ThemeEncoderData? extractThemeEncoderData(ElementAnnotation? annotation, DartObject constantValue) {
  final encoderClassElement = constantValue.type!.element as ClassElement?;
  if (encoderClassElement == null) return null;

  final encoderSuper = encoderClassElement.allSupertypes.singleWhereOrNull((e) {
    return themeEncoderChecker.isExactlyType(e);
  });

  if (encoderSuper == null) return null;
  final genericTypeArg = (constantValue.type! as InterfaceType).typeArguments.firstOrNull;

  final encoderType = genericTypeArg ?? encoderSuper.typeArguments[0];

  final encoderTypeStr = encoderType.toString();

  final annotationElement = annotation?.element;
  if (annotationElement is PropertyAccessorElement) {
    final enclosing = annotationElement.enclosingElement3;

    var accessString = annotationElement.name;

    if (enclosing is ClassElement) {
      accessString = '${enclosing.name}.$accessString';
    }

    return ThemeEncoderData.propertyAccess(
      accessString,
      encoderTypeStr,
    );
  }

  final reviver = ConstantReader(constantValue).revive();

  if (reviver.namedArguments.isNotEmpty || reviver.positionalArguments.isNotEmpty) {
    throw InvalidGenerationSourceError(
      'ThemeEncoders with constructor arguments are not supported',
      element: annotation?.element,
      todo: 'Remove constructor parameters from ${annotation?.element}',
    );
  }

  return ThemeEncoderData.className(
    constantValue.type!.element!.name!,
    reviver.accessor,
    encoderTypeStr,
    isGeneric: genericTypeArg != null,
  );
}
