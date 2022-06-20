import 'dart:convert';
import 'dart:io';

import '../models/app_typography.dart';
import '../utils/utils.dart';

class ClassTypographyTemplate {
  ClassTypographyTemplate({
    required this.className,
    required this.file,
  });

  final String className;
  final FileSystemEntity file;

  Future<String> generate() async {
    return '''
${_importsGenerate()}

${await _classGenerate()}
''';
  }

  String _importsGenerate() {
    return '''
import 'package:flutter/material.dart';
''';
  }

  Future<String> _classGenerate() async {
    return '''
class $className {
const $className._();

${await _generateTypographyBody()}
''';
  }

  Future<List<AppTypography>> _parseJson() async {
    final typographyList = <AppTypography>[];

    final fileData = File(file.path);

    final dynamic data = json.decode(await fileData.readAsString());
    if (data is! Map<String, dynamic>) return typographyList;

    data.map((key, value) {
      if (value is! Map<String, dynamic>) return MapEntry(key, value);

      var appTypography = AppTypography.fromJson(value['value']);

      appTypography = appTypography.copyWith(name: key);

      typographyList.add(appTypography);

      return MapEntry(key, value);
    });

    return typographyList;
  }

  Future<String> _generateTypographyBody() async {
    final typographyList = await _parseJson();

    final buffer = StringBuffer();

    for (final typography in typographyList) {
      buffer.writeln(
        '\nstatic const TextStyle ${_getTypographyName(typography.name!)} = TextStyle(${typographyParser(typography)});',
      );
    }

    return buffer.toString();
  }

  String _getTypographyName(String name) {
    return name.replaceAll(RegExp("[^A-Za-z0-9]"), "").replaceAll(" ", "");
  }
}
