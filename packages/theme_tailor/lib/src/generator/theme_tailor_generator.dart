import 'dart:collection';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../model/theme_extension_config.dart';
import '../template/theme_extension_class_templates.dart';
import '../util/util.dart';

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

    final astTailorClassVisitor = _ASTTailorClassVisitor(stringUtil);
    _getAstNodeFromElement(element).visitChildren(astTailorClassVisitor);

    final config = ThemeExtensionClassConfig(
      expressions: astTailorClassVisitor.expressions,
      fields: tailorClassVisitor.fields,
      returnType: tailorClassVisitor.returnType,
      themes: themes,
    );

    final debug = '''
    // DEBUG:
    // Class name: ${config.returnType}
    // Themes: ${config.themes.join(' ')}
    // Properties: ${config.fields.entries}
    // Expressions: ${config.expressions.entries}\n
    ''';

    final outputBuffer = StringBuffer(debug)..write(ThemeExtensionClassTemplate(config));

    return outputBuffer.toString();
  }
}

AstNode _getAstNodeFromElement(Element element) {
  final session = element.session!;
  final parsedLibResult = session.getParsedLibraryByElement(element.library!) as ParsedLibraryResult;
  final elDeclarationResult = parsedLibResult.getElementDeclaration(element)!;
  return elDeclarationResult.node;
}

/// Only supports getters
class _ASTTailorClassVisitor extends GeneralizingAstVisitor {
  _ASTTailorClassVisitor(this._stringUtil);

  final StringUtil _stringUtil;

  SplayTreeMap<String, Expression> expressions = SplayTreeMap();

  @override
  void visitAnnotation(Annotation node) {
    print(node);
  }

  @override
  void visitClassMember(ClassMember node) {
    final getterName = _stringUtil.getGetterName(node.toString());
    if (getterName == null) return;

    final fun = node.childEntities.firstWhereOrNull((e) => e is ExpressionFunctionBody) as ExpressionFunctionBody;
    expressions[getterName] = fun.expression;
  }
}

/// Only supports getters
class _TailorClassVisitor extends SimpleElementVisitor {
  _TailorClassVisitor(this._stringUtil);

  final StringUtil _stringUtil;

  String returnType = '';
  SplayTreeMap<String, String> fields = SplayTreeMap();

  @override
  void visitConstructorElement(ConstructorElement element) {
    returnType = _stringUtil.formatClassName(element.type.returnType.toString());
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (element.getter != null) {
      final type = _stringUtil.getTypeFromList(element.type.toString());
      if (type == null) throw InvalidGenerationSourceError('Getters must have a List<T> return type', element: element);
      fields[element.name] = type;
    }
  }
}
