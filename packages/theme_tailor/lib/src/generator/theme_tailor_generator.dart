import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../util/regexp.dart';

class ThemeTailorGenerator extends GeneratorForAnnotation<Tailor> {
  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement || element is Enum) {
      throw InvalidGenerationSourceError('Tailor can only annotate classes', element: element);
    }

    final themeNames = annotation.read('themes').listValue.map((e) => e.toStringValue());

    final tailorClassVisitor = TailorClassVisitor();
    element.visitChildren(tailorClassVisitor);

    final astTailorClassVisitor = ASTTailorClassVisitor();
    getAstNodeFromElement(element).visitChildren(astTailorClassVisitor);

    final debug = '''
DEBUG:
Class name: ${tailorClassVisitor.className}
Themes: ${themeNames.join(' ')}
Properties: ${tailorClassVisitor.fields.entries}
Expressions: ${astTailorClassVisitor.expressions.entries}
''';

    print(debug);
    return multiLineCommented(debug);
  }
}

String multiLineCommented(String val) => '/*$val*/';
String commented(String val) => '/// $val';

AstNode getAstNodeFromElement(Element element) {
  final session = element.session!;
  final parsedLibResult = session.getParsedLibraryByElement(element.library!) as ParsedLibraryResult;
  final elDeclarationResult = parsedLibResult.getElementDeclaration(element)!;
  return elDeclarationResult.node;
}

class ASTTailorClassVisitor extends GeneralizingAstVisitor {
  Map<String, Expression> expressions = {};

  @override
  void visitAnnotation(Annotation node) {
    print(node);
  }

  @override
  void visitClassMember(ClassMember node) {
    /// Only supporting getters for theme data
    final getterName = findGetterName(node.toString());
    if (getterName == null) return;

    final fun = node.childEntities.firstWhereOrNull((e) => e is ExpressionFunctionBody) as ExpressionFunctionBody;
    expressions[getterName] = fun.expression;
  }
}

class TailorClassVisitor extends SimpleElementVisitor {
  late DartType className;
  Map<String, DartType> fields = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (element.getter != null) fields[element.name] = element.type;
  }
}
