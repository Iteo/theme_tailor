import 'package:test/test.dart';
import 'package:theme_tailor/src/util/field_helper.dart';

void main() {
  group(
    'Field helper',
    () {
      test(
        'getFreeFieldName works correctly',
        () {
          final proposedNames = ['x', 'y', 'z'];
          String fun(List<String> fieldNames) => getFreeFieldName(
                fieldNames: fieldNames,
                proposedNames: proposedNames,
                warningPropertyName: '',
              );

          var test = proposedNames.sublist(0, 1);
          expect(fun(test), proposedNames[1]);

          test = proposedNames.sublist(0, 2);
          expect(fun(test), proposedNames[2]);

          test = proposedNames.sublist(2, 3);
          expect(fun(test), proposedNames[0]);

          test = proposedNames;
          expect(fun(proposedNames), '${proposedNames[0]}0');

          test = [...proposedNames, '${proposedNames[0]}0'];
          expect(fun(test), '${proposedNames[0]}1');
        },
      );
    },
  );
}
