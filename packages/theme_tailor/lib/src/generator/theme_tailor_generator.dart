import 'dart:collection';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/model/theme_extension_config.dart';
import 'package:theme_tailor/src/template/theme_extension_class_templates.dart';
import 'package:theme_tailor/src/type_helper/iterable_helper.dart';
import 'package:theme_tailor/src/util/util.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../type_helper/theme_encoder_helper.dart';

class ThemeTailorGenerator extends GeneratorForAnnotation<Tailor> {
  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement || element is Enum) {
      throw InvalidGenerationSourceError('Tailor can only annotate classes', element: element);
    }

    const stringUtil = StringUtil();

    final className = element.name;
    final themes = SplayTreeSet<String>.from(annotation.read('themes').listValue.map((e) => e.toStringValue()));
    final encodersReader = annotation.read('encoders');

    // if (!encodersReader.isNull) {
    //   for (final object in encodersReader.listValue) {
    //     themeEncoderMatchfromDartObject(null, object);
    //   }
    // }

    for (final annotation in element.metadata) {
      print(extractThemeEncoderData(annotation, annotation.computeConstantValue()!));
    }

    final tailorClassVisitor = _TailorClassVisitor();
    element.visitChildren(tailorClassVisitor);

    final config = ThemeExtensionClassConfig(
      fields: tailorClassVisitor.fields,
      returnType: stringUtil.formatClassName(className),
      baseClassName: className,
      themes: themes,
      encoders: encodersReader.isNull ? const [] : encodersReader.listValue,
    );

    final debug = '''
    // DEBUG:
    // Class name: ${config.returnType}
    // Themes: ${config.themes.join(' ')}
    // Properties: ${config.fields.entries}
    // Encoders: ${config.encoders}
    ''';

    // print(debug);

    final outputBuffer = StringBuffer(debug)..write(ThemeExtensionClassTemplate(config));

    return outputBuffer.toString();
  }
}

AstNode getAstNodeFromElement(Element element) {
  final session = element.session!;
  final parsedLibResult = session.getParsedLibraryByElement(element.library!) as ParsedLibraryResult;
  final elDeclarationResult = parsedLibResult.getElementDeclaration(element)!;
  return elDeclarationResult.node;
}

class _TailorClassVisitor extends SimpleElementVisitor {
  SplayTreeMap<String, DartType> fields = SplayTreeMap();

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isStatic && element.type.isDartCoreList) {
      fields[element.name] = coreIterableGenericType(element.type);

      if (element.metadata.isNotEmpty) {
        // print('$element metadata: ${element.metadata}');
        for (final annotation in element.metadata) {
          // final match = themeEncoderMatchfromDartObject(annotation, annotation.computeConstantValue()!);
          // print(match);
        }
      }
    }
  }
}
