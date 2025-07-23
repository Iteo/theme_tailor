import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

const themeEncoderChecker = TypeChecker.fromRuntime(ThemeEncoder);

ThemeEncoderData? extractThemeEncoderData(ElementAnnotation? annotation, DartObject constantValue) {
  final encoderClassElement = constantValue.type!.element3 as ClassElement2?;
  if (encoderClassElement == null) return null;

  final encoderSuper = encoderClassElement.allSupertypes.singleWhereOrNull((e) {
    return themeEncoderChecker.isExactlyType(e);
  });

  if (encoderSuper == null) return null;
  final genericTypeArg = (constantValue.type! as InterfaceType).typeArguments.firstOrNull;

  final encoderType = genericTypeArg ?? encoderSuper.typeArguments[0];

  final encoderTypeStr = encoderType.toString();

  final annotationElement = annotation?.element2;
  if (annotationElement is PropertyAccessorElement2) {
    final enclosing = annotationElement.enclosingElement2;

    var accessString = annotationElement.name3;

    if (enclosing is ClassElement2) {
      accessString = '${enclosing.name3}.$accessString';
    }

    return ThemeEncoderData.propertyAccess(
      accessString!,
      encoderTypeStr,
    );
  }

  final reviver = ConstantReader(constantValue).revive();

  if (reviver.namedArguments.isNotEmpty || reviver.positionalArguments.isNotEmpty) {
    throw InvalidGenerationSourceError(
      'ThemeEncoders with constructor arguments are not supported',
      element: annotation?.element2,
      todo: 'Remove constructor parameters from ${annotation?.element2}',
    );
  }

  return ThemeEncoderData.className(
    constantValue.type!.element3!.name3!,
    reviver.accessor,
    encoderTypeStr,
    isGeneric: genericTypeArg != null,
  );
}
