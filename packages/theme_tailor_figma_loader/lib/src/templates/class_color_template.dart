import 'dart:convert';
import 'dart:io';

import '../models/app_color.dart';
import '../utils/utils.dart';

class ClassColorTemplate {
  ClassColorTemplate({required this.files, required this.className});

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

${await _generateColorBody()}
''';
  }

  Future<List<AppColor>> _parseJson() async {
    final colorList = <AppColor>[];

    for (var file in files) {
      final fileData = File(file.path);

      final dynamic data = json.decode(await fileData.readAsString());
      if (data is! Map<String, dynamic>) return colorList;

      data.map((key, value) {
        if (value is Map<String, dynamic>) {
          value.map((k, v) {
            try {
              if (v is! Map<String, dynamic>) throw 'error';

              final appColor = AppColor(
                parent: key,
                name: _getColorName(key, k),
                color: toColor(v['value'] as String),
              );

              colorList.add(appColor);
            } catch (e) {
              printError('can\'t parse color');
            }
            return MapEntry(k, v);
          });
        }

        return MapEntry(key, value);
      });
    }

    return Future.value(colorList);
  }

  Future<String> _generateColorBody() async {
    final colorList = await _parseJson();

    final buffer = StringBuffer();
    String? previuseParent;

    for (final color in colorList) {
      if (previuseParent != null && color.parent != previuseParent) {
        buffer.write('\n');
      }

      buffer.writeln('  static const Color ${color.name} = ${color.color};');
      previuseParent = color.parent;
    }

    return buffer.toString();
  }

  String _getColorName(String key, String name) {
    return '$key${name.toString().substring(0, 1).toUpperCase()}${name.toString().substring(1)}';
  }
}
