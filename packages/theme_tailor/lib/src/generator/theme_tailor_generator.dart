import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/model/annotation_data.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_class_config.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/model/theme_getter_data.dart';
import 'package:theme_tailor/src/template/theme_class_template.dart';
import 'package:theme_tailor/src/template/theme_extension_template.dart';
import 'package:theme_tailor/src/util/iterable_helper.dart';
import 'package:theme_tailor/src/util/json_serializable_helper.dart';
import 'package:theme_tailor/src/util/string_format.dart';
import 'package:theme_tailor/src/util/theme_encoder_helper.dart';
import 'package:theme_tailor/src/util/theme_getter_helper.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

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
    final themes = _computeThemes(annotation);
    final themeGetter = _computeThemeGetter(annotation);

    final classLevelEncoders = _computeEncoders(annotation);
    final classLevelAnnotations = <String>[];
    final fieldLevelAnnotations = <String, List<String>>{};

    final astVisitor = _TailorClassASTVisitor();
    _getAstNodeFromElement(element).visitChildren(astVisitor);

    for (var i = 0; i < element.metadata.length; i++) {
      final annotation = element.metadata[i];

      final encoder = extractThemeEncoderData(
        annotation,
        annotation.computeConstantValue()!,
      );

      if (encoder != null) {
        classLevelEncoders[encoder.type] = encoder;
        continue;
      }
      if (isTailorAnnotation(annotation)) continue;
      classLevelAnnotations.add(astVisitor.rawClassAnnotations[i]);
    }

    final tailorClassVisitor = _TailorClassVisitor();
    element.visitChildren(tailorClassVisitor);

    tailorClassVisitor.consumedFieldsAnnotations.entries
        .forEachIndexed((index, element) {
      if (element.value.isEmpty) return;

      final annotations = <String>[];

      element.value.forEachIndexed((index, isConsumed) {
        late final value = astVisitor.rawFieldsAnnotations[element.key]![index];
        if (!isConsumed) annotations.add(value);
      });
      fieldLevelAnnotations[element.key] = annotations;
    });

    fieldLevelAnnotations.forEach((key, value) {
      print('key: $key, value: $value');
    });

    final encoderDataManager = ThemeEncoderDataManager(
      classLevelEncoders,
      tailorClassVisitor.fieldLevelEncoders,
    );

    final annotationDataManager = AnnotationDataManager(
      classAnnotations: classLevelAnnotations,
      fieldsAnotations: fieldLevelAnnotations,
      hasJsonSerializable: element.hasJsonSerializableAnnotation,
    );

    final config = ThemeClassConfig(
      fields: tailorClassVisitor.fields,
      returnType: stringUtil.themeClassName(className),
      baseClassName: className,
      themes: themes,
      encoderDataManager: encoderDataManager,
      themeGetter: themeGetter,
      annotationDataManager: annotationDataManager,
    );

    final generatorBuffer = StringBuffer(
      ThemeClassTemplate(config, stringUtil),
    );
    ThemeExtensionTemplate(config, stringUtil).writeBuffer(generatorBuffer);

    return generatorBuffer.toString();
  }

  bool isTailorAnnotation(ElementAnnotation element) {
    const tailorAnnotation = TypeChecker.fromRuntime(Tailor);
    return tailorAnnotation
        .isAssignableFromType(element.computeConstantValue()!.type!);
  }

  List<String> _computeThemes(ConstantReader annotation) {
    return List<String>.from(
      annotation.read('themes').listValue.map((e) => e.toStringValue()),
    );
  }

  ExtensionData _computeThemeGetter(ConstantReader annotation) {
    return themeGetterDataFromData(annotation.read('themeGetter'));
  }

  Map<String, ThemeEncoderData> _computeEncoders(ConstantReader annotation) {
    final encodersReader = annotation.read('encoders');
    final encoders = <String, ThemeEncoderData>{};
    if (encodersReader.isNull) return encoders;

    for (final object in encodersReader.listValue) {
      final encoderData = extractThemeEncoderData(null, object);
      if (encoderData != null) encoders[encoderData.type] = encoderData;
    }
    return encoders;
  }
}

class _TailorClassVisitor extends SimpleElementVisitor {
  final Map<String, Field> fields = {};
  final Map<String, ThemeEncoderData> fieldLevelEncoders = {};
  final Map<String, List<bool>> consumedFieldsAnnotations = {};

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isStatic && element.type.isDartCoreList) {
      final propName = element.name;
      final consumedFieldAnnotations = <bool>[];

      for (final annotation in element.metadata) {
        final encoderData = extractThemeEncoderData(
          annotation,
          annotation.computeConstantValue()!,
        );

        if (encoderData != null) {
          consumedFieldAnnotations.add(true);
          fieldLevelEncoders[propName] = encoderData;
        } else {
          consumedFieldAnnotations.add(false);
        }
      }

      consumedFieldsAnnotations[propName] = consumedFieldAnnotations;
      fields[propName] = Field(propName, coreIterableGenericType(element.type));
    }
  }
}

class _TailorClassASTVisitor extends SimpleAstVisitor {
  final List<String> rawClassAnnotations = [];
  final Map<String, List<String>> rawFieldsAnnotations = {};

  @override
  void visitAnnotation(Annotation node) {
    rawClassAnnotations.add(node.toString());
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    rawFieldsAnnotations[node.name] = node.annotations;
  }
}

AstNode _getAstNodeFromElement(Element element) {
  final session = element.session!;
  final parsedLibResult = session.getParsedLibraryByElement(element.library!)
      as ParsedLibraryResult;
  final elDeclarationResult = parsedLibResult.getElementDeclaration(element)!;
  return elDeclarationResult.node;
}

extension FieldDeclarationExtension on FieldDeclaration {
  String get name => fields.variables.first.name.name;

  List<String> get annotations {
    return metadata.map((e) => e.toString()).toList(growable: false);
  }
}
