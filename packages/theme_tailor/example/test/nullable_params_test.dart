import 'package:example/nullable_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Nullable params are not required',
    () {
      NullableParams(
        background: Colors.green,
      );
    },
  );
}
