// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import '../models/app_typography.dart';
import '../utils/utils.dart';

class ClassTypographyTemplate {
  ClassTypographyTemplate({required this.files, required this.className});

  final List<FileSystemEntity> files;
  final String className;

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

    for (var file in files) {
      final fileData = File(file.path);

      final dynamic data = json.decode(await fileData.readAsString());
      if (data is! Map<String, dynamic>) return typographyList;

      data.map((key, value) {
        if (value is! Map<String, dynamic>) return MapEntry(key, value);

        var appTypography = AppTypography(name: key);

        appTypography = appTypography.copyWith(
          description: value['description'] as String?,
          fontFamily: value['value']['fontFamily'] as String?,
          fontSize: value['value']['fontSize'] as int?,
          height: value['value']['lineHeight'] as int?,
          fontStyle: value['value']['fontStyle'] as String?,
          letterSpacing: value['value']['letterSpacing'] as int?,
          fontWeight: value['value']['fontWeight'] as int?,
        );

        typographyList.add(appTypography);

        return MapEntry(key, value);
      });
    }

    return Future.value(typographyList);
  }

  Future<String> _generateTypographyBody() async {
    final typographyList = await _parseJson();

    final buffer = StringBuffer();

    for (final typography in typographyList) {
      buffer.writeln(
        '  static const TextStyle ${typography.name} = TextStyle(${typographyParser(typography)}\n  );\n',
      );
    }

    return buffer.toString();
  }
}
