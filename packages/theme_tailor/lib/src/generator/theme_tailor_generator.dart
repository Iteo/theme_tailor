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

class ThemeTailorGenerator extends GeneratorForAnnotation<Tailor> {
  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement || element is Enum) {
      throw InvalidGenerationSourceError('Tailor can only annotate classes', element: element);
    }

    final themes = SplayTreeSet<String>.from(annotation.read('themes').listValue.map((e) => e.toStringValue()));
    const stringUtil = StringUtil();

    final tailorClassVisitor = _TailorClassVisitor(stringUtil);
    element.visitChildren(tailorClassVisitor);

    final config = ThemeExtensionClassConfig(
      fields: tailorClassVisitor.fields,
      returnType: tailorClassVisitor.classNameClean,
      baseClassName: tailorClassVisitor._baseClassName,
      themes: themes,
    );

    final debug = '''
    // DEBUG:
    // Class name: ${config.returnType}
    // Themes: ${config.themes.join(' ')}
    // Properties: ${config.fields.entries}
    ''';

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
  _TailorClassVisitor(this._stringUtil);

  final StringUtil _stringUtil;

  String _baseClassName = '';
  String get classNameClean => _stringUtil.formatClassName(_baseClassName);
  SplayTreeMap<String, DartType> fields = SplayTreeMap();

  @override
  void visitConstructorElement(ConstructorElement element) {
    _baseClassName = element.type.returnType.toString();
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isStatic && element.type.isDartCoreList) {
      print(coreIterableGenericType(element.type));
      fields[element.name] = coreIterableGenericType(element.type);
    }
  }
}
