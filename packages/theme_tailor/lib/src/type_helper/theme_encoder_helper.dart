import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../model/theme_encoder_data.dart';

const themeEncoderChecker = TypeChecker.fromRuntime(ThemeEncoder);

ThemeEncoderData? extractThemeEncoderData(
    ElementAnnotation? annotation, DartObject constantValue) {
  final encoderClassElement = constantValue.type!.element as ClassElement;

  final encoderSuper = encoderClassElement.allSupertypes.singleWhereOrNull((e) {
    return themeEncoderChecker.isExactly(e.element);
  });

  if (encoderSuper == null) return null;

  final encoderType = encoderSuper.typeArguments[0];
  final encoderTypeStr = encoderType.toString();

  final annotationElement = annotation?.element;
  if (annotationElement is PropertyAccessorElement) {
    final enclosing = annotationElement.enclosingElement;

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

  if (reviver.namedArguments.isNotEmpty ||
      reviver.positionalArguments.isNotEmpty) {
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
  );
}
