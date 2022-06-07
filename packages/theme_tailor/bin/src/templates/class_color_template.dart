import 'dart:convert';
import 'dart:io';

import '../models/app_color.dart';
import '../utils/utils.dart';

class ClassColorTemplate {
  const ClassColorTemplate({
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

${await _generateColorBody()}
''';
  }

  Future<List<AppColor>> _parseJson() async {
    final colorList = <AppColor>[];

    final fileData = File(file.path);

    final dynamic data = json.decode(await fileData.readAsString());
    if (data is! Map<String, dynamic>) return colorList;

    data.map((key, value) {
      if (value is Map<String, dynamic>) {
        value.map((k, v) {
          try {
            if (v is! Map<String, dynamic>) throw 'error';

            AppColor appColor = AppColor.fromJson(v);

            appColor = appColor.copyWith(
              color: toColor(v['value'] as String),
              name: _getColorName(key, k),
              parent: key,
            );

            colorList.add(appColor);
          } catch (e) {
            printError("can't parse color");
          }
          return MapEntry(k, v);
        });
      }

      return MapEntry(key, value);
    });

    return colorList;
  }

  Future<String> _generateColorBody() async {
    final colorList = await _parseJson();

    final buffer = StringBuffer();
    String? previouseParent;

    for (final color in colorList) {
      if (previouseParent != null && color.parent != previouseParent) {
        buffer.write('\n');
      }

      buffer.writeln('static const Color ${color.name} = ${color.color};');
      previouseParent = color.parent;
    }

    return buffer.toString();
  }

  String _getColorName(String key, String name) {
    return '$key${name.substring(0, 1).toUpperCase()}${name.substring(1)}';
  }
}
