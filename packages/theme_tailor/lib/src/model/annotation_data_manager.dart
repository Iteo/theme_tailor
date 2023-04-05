class AnnotationDataManager {
  AnnotationDataManager({
    required this.classAnnotations,
    required this.fieldsAnotations,
  });

  final List<String> classAnnotations;
  final Map<String, List<String>> fieldsAnotations;

  String expandClassAnnotations() {
    return '${classAnnotations.join('\n')}\n';
  }

  String expandFieldAnnotations(String name) {
    return '${_annotationsForField(name).join(' ')}\n';
  }

  List<String> _annotationsForField(String name) {
    return fieldsAnotations[name] ?? [];
  }
}
