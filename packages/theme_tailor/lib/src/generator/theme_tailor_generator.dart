import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_class_config.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/template/theme_class_template.dart';
import 'package:theme_tailor/src/template/theme_extension_template.dart';
import 'package:theme_tailor/src/util/iterable_helper.dart';
import 'package:theme_tailor/src/util/string_format.dart';
import 'package:theme_tailor/src/util/theme_encoder_helper.dart';
import 'package:theme_tailor/src/util/theme_getter_helper.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

bool _libraryHasElement(
  LibraryElement library,
  String pathStartsWith,
  bool Function(Element element) matcher,
) {
  if (library.librarySource.fullName.startsWith(pathStartsWith)) {
    for (final element in library.topLevelElements) {
      if (matcher(element)) {
        return true;
      }
    }
  }

  return library.exportedLibraries.any((library) {
    return library.librarySource.fullName.startsWith(pathStartsWith) &&
        _libraryHasElement(library, pathStartsWith, matcher);
  });
}

bool _libraryHasJson(LibraryElement library) {
  return _libraryHasElement(
    library,
    '/json_annotation/',
    (element) =>
        element.displayName.contains('JsonSerializable') &&
        element.kind == ElementKind.CLASS,
  );
}

class ThemeTailorGenerator extends GeneratorForAnnotation<Tailor> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement || element is Enum) {
      throw InvalidGenerationSourceError(
        'Tailor can only annotate classes',
        element: element,
        todo: 'Move @Tailor annotation above `class`',
      );
    }

    const stringUtil = StringFormat();

    final className = element.name;
    final themes = List<String>.from(
        annotation.read('themes').listValue.map((e) => e.toStringValue()));

    final themeGetter = themeGetterDataFromData(annotation.read('themeGetter'));

    final encodersReader = annotation.read('encoders');

    final classLevelEncoders = <String, ThemeEncoderData>{};

    if (!encodersReader.isNull) {
      for (final object in encodersReader.listValue) {
        final encoderData = extractThemeEncoderData(null, object);
        if (encoderData != null) {
          classLevelEncoders[encoderData.type] = encoderData;
        }
      }
    }

    for (final annotation in element.metadata) {
      final encoderData = extractThemeEncoderData(
          annotation, annotation.computeConstantValue()!);
      if (encoderData != null) {
        classLevelEncoders[encoderData.type] = encoderData;
      }
    }

    final tailorClassVisitor = _TailorClassVisitor();
    element.visitChildren(tailorClassVisitor);

    final config = ThemeClassConfig(
      fields: tailorClassVisitor.fields,
      returnType: stringUtil.themeClassName(className),
      baseClassName: className,
      themes: themes,
      encoderDataManager: ThemeEncoderDataManager(
        classLevelEncoders,
        tailorClassVisitor.fieldLevelEncoders,
      ),
      themeGetter: themeGetter,
    );

    final generatorBuffer = StringBuffer(
      ThemeClassTemplate(config, stringUtil),
    );
    ThemeExtensionTemplate(config, stringUtil).writeBuffer(generatorBuffer);

    return generatorBuffer.toString();
  }
}

class _TailorClassVisitor extends SimpleElementVisitor {
  final Map<String, Field> fields = {};
  final Map<String, ThemeEncoderData> fieldLevelEncoders = {};

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isStatic && element.type.isDartCoreList) {
      final propName = element.name;

      if (element.metadata.isNotEmpty) {
        for (final annotation in element.metadata) {
          final encoderData = extractThemeEncoderData(
            annotation,
            annotation.computeConstantValue()!,
          );

          if (encoderData != null) {
            fieldLevelEncoders[propName] = encoderData;
          }
        }
      }

      fields[propName] = Field(propName, coreIterableGenericType(element.type));
    }
  }

  @override
  void visitImportElement(ImportElement element) {
    return super.visitImportElement(element);
  }
}
