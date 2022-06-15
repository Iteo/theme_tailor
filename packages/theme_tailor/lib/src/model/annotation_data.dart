// ignore_for_file: prefer_interpolation_to_compose_strings

class AnnotationData {
  const AnnotationData(this.accessor, this.isConsumed);

  /// Annotation is for internal use and won't be copied over the fields
  factory AnnotationData.consumed() => const AnnotationData(null, true);

  /// Annotation is reserved by DartElement and is waiting for
  /// data from AST node
  factory AnnotationData.reserve() => const AnnotationData(null, false);

  /// Annotation is ready to be copied over field with valid accessor data
  factory AnnotationData.accessor(String a) => AnnotationData(a, false);

  /// If annotation is not yet processed by AST node it will be empty
  final String? accessor;

  /// Consumed annotations are not copied over to fields
  final bool isConsumed;

  @override
  String toString() => isConsumed || accessor == null ? '' : accessor!;
}

class AnnotationDataManager {
  AnnotationDataManager({
    required this.classAnnotations,
    required this.fieldsAnotations,
    required this.hasJsonSerializable,
  });

  final List<String> classAnnotations;
  final Map<String, List<String>> fieldsAnotations;
  final bool hasJsonSerializable;

  String expandClassAnnotations() => classAnnotations.join('\n') + '\n';

  String expandFieldAnnotations(String name) =>
      annotationsForField(name).join(' ') + '\n';

  List<String> annotationsForField(String name) {
    return fieldsAnotations[name] ?? [];
  }
}
