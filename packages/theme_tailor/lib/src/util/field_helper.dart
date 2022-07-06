import 'dart:math';

String getFreeFieldName({
  required List<String> fieldNames,
  required List<String> proposedNames,
  required String warningPropertyName,
}) {
  assert(proposedNames.isNotEmpty);

  var i = 0;
  while (true) {
    final fieldName = proposedNames.length > i
        ? proposedNames[i]
        : '${proposedNames[0]}${i - proposedNames.length}';

    if (!fieldNames.contains(fieldName)) {
      if (i != 0) {
        final unavailablePropertyNames = proposedNames
            .sublist(0, min(proposedNames.length, i))
            .map((e) => '"$e"')
            .toList();
        print(
          '$unavailablePropertyNames property name(s) for $warningPropertyName '
          'would result in name collision, generated "$fieldName" instead.',
        );
      }

      return fieldName;
    }
    i++;
  }
}
