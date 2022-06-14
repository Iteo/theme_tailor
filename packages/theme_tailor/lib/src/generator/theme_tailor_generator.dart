import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';
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

    final astNode = _getAstNodeFromElement(element);
    final astVisitor = ListFieldTypeASTVisitor();
    astNode.visitChildren(astVisitor);

    final tailorClassVisitor =
        _TailorClassVisitor(fieldTypes: astVisitor.fieldTypes);
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
  _TailorClassVisitor({required this.fieldTypes});

  final Map<String, String> fieldTypes;

  final Map<String, Field> fields = {};
  final Map<String, ThemeEncoderData> fieldLevelEncoders = {};
  final extensionAnnotationTypeChecker =
      TypeChecker.fromRuntime(themeExtension.runtimeType);

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isStatic && element.type.isDartCoreList) {
      final propName = element.name;
      final coreType = coreIterableGenericType(element.type);
      final extendsThemeExtension = coreType.typeImplementations
              .firstWhereOrNull((t) => t
                  .getDisplayString(withNullability: false)
                  .startsWith('ThemeExtension')) !=
          null;
      final isThemeComponent =
          extensionAnnotationTypeChecker.hasAnnotationOf(element);
      final isThemeExtension = isThemeComponent || extendsThemeExtension;

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

      final coreTypeName = coreType.getDisplayString(withNullability: false);
      final typeName = isThemeComponent
          ? fieldTypes[element.name] ?? coreTypeName
          : coreTypeName;

      fields[propName] = Field(
        name: propName,
        typeName: typeName,
        isThemeExtension: isThemeExtension,
      );
    }
  }
}

class ListFieldTypeASTVisitor extends SimpleAstVisitor {
  Map<String, String> fieldTypes = {};

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    final fieldType = node.fields.type;
    if (fieldType != null) {
      final childTypeEntities =
          fieldType.childEntities.map((e) => e.toString()).toList();
      if (childTypeEntities.length >= 2 && childTypeEntities[0] == 'List') {
        final typeWithBraces = childTypeEntities[1];
        fieldTypes[node.fields.variables.first.name.name] =
            typeWithBraces.substring(1, typeWithBraces.length - 1);
      }
    }
  }
}

AstNode _getAstNodeFromElement(Element element) {
  final session = element.session!;
  final parsedLibResult = session.getParsedLibraryByElement(element.library!)
      as ParsedLibraryResult;
  final elDeclarationResult = parsedLibResult.getElementDeclaration(element)!;
  return elDeclarationResult.node;
}
