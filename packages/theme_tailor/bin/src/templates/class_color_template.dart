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
import 'dart:ui';
''';
  }

  Future<String> _classGenerate() async {
    var colorList = await _parseJson();

    return '''
abstract class $className {
const $className({
  ${_generateConstructorParams(colorList)},
});

${_generateParams(colorList)}

${_generateColorMaps(colorList)}
  }

class Light$className extends $className {
  const Light$className()
      : super(
        ${_generateSuperParam(colorList, false)},
        );
}

class Dark$className extends $className {
  const Dark$className()
      : super(
          ${_generateSuperParam(colorList, true)},
        );
''';
  }

  String _generateConstructorParams(List<AppColor> colors) {
    colors.sort((a, b) => a.name!.compareTo(b.name!));

    return colors
        .where((element) => !element.isDark)
        .map((e) => 'required this.${e.name}')
        .join(',');
  }

  String _generateParams(List<AppColor> colors) {
    final buffer = StringBuffer();
    String? previouseParent;
    var map = <String, List<AppColor>>{};

    for (final color in colors.where((element) => !element.isDark)) {
      if (map[color.parent!] == null) {
        map[color.parent!] = [color];
      } else {
        map[color.parent!]?.add(color);
      }
    }

    for (final parent in map.keys) {
      var colorList = map[parent]!;

      colorList.sort((a, b) => a.name!.compareTo(b.name!));

      for (final color in colorList) {
        if (previouseParent == null || color.parent! != previouseParent) {
          buffer.writeln('\n // ${color.parent}');
        }

        buffer.writeln('final Color ${color.name};');
        previouseParent = color.parent;
      }
    }

    return buffer.toString();
  }

  String _generateSuperParam(List<AppColor> colors, bool isDark) {
    var light = colors.where((element) => !element.isDark).toList();
    var dark = colors.where((element) => element.isDark).toList();

    for (var color in light) {
      try {
        dark.firstWhere((element) => element.name == color.name);
      } catch (e) {
        dark.add(color);
      }
    }

    for (var color in dark) {
      try {
        light.firstWhere((element) => element.name == color.name);
      } catch (e) {
        light.add(color);
      }
    }

    light.sort((a, b) => a.name!.compareTo(b.name!));
    dark.sort((a, b) => a.name!.compareTo(b.name!));

    return (isDark ? dark : light)
        .map((e) => '${e.name}: const ${e.color}')
        .join(',');
  }

  String _generateColorMaps(List<AppColor> colors) {
    final buffer = StringBuffer();
    var map = <String, List<AppColor>>{};

    for (final color in colors.where((element) => !element.isDark)) {
      if (map[color.parent!] == null) {
        map[color.parent!] = [color];
      } else {
        map[color.parent!]?.add(color);
      }
    }

    for (final parent in map.keys) {
      var colorList = map[parent]!;

      colorList.sort((a, b) => a.name!.compareTo(b.name!));

      buffer.writeln('\nMap<String, Color> get ${parent}Colors => {');

      for (final color in colorList) {
        buffer.writeln('"${color.description}": ${color.name},');
      }

      buffer.writeln("};");
    }

    return buffer.toString();
  }

  Future<List<AppColor>> _parseJson() async {
    final colorList = <AppColor>[];
    final fileData = File(file.path);
    final dynamic data = json.decode(await fileData.readAsString());

    if (data is! Map<String, dynamic>) return colorList;

    colorList.addAll(_getAppColor(data));
    colorList.sort((a, b) => a.parent!.compareTo(b.parent!));

    return colorList;
  }

  List<AppColor> _getAppColor(Map<String, dynamic> data,
      {String? name, bool? isDark}) {
    final colorList = <AppColor>[];

    data.map((key, value) {
      if (value['type'] == null || value['type'] != 'color') {
        colorList.addAll(
          _getAppColor(
            value,
            name: key,
            isDark: isDark ?? name?.startsWith("dark"),
          ),
        );
      } else {
        AppColor appColor = AppColor.fromJson(value);

        appColor = appColor.copyWith(
          color: toColor(value['value'] as String),
          name: _getColorName(key),
          description: key,
          isDark: isDark,
          parent: name,
        );

        colorList.add(appColor);
      }

      return MapEntry(key, value);
    });

    return colorList;
  }

  String _getColorName(String name) {
    name = name
        .split(" ")
        .map<String>((e) {
          if (e.contains("(100)")) {
            return e.replaceAll("(100)", "");
          } else if (e.contains("(") && e.contains(")")) {
            return "opacity${e.substring(0)}";
          }

          return '${e.substring(0, 1).toUpperCase()}${e.substring(1)}';
        })
        .join()
        .replaceAll(RegExp("[^A-Za-z0-9]"), "");

    return '${name.substring(0, 1).toLowerCase()}${name.substring(1)}';
  }
}
