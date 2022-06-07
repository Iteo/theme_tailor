import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'src/templates/class_color_template.dart';
import 'src/templates/class_typography_template.dart';
import 'src/utils/utils.dart';

Future<void> main(List<String> args) async {
  if (_isHelpCommand(args)) {
    _printHelperDisplay();
  } else {
    await handleStyleFiles(_generateOption(args));
  }
}

bool _isHelpCommand(List<String> args) {
  return args.length == 1 && (args[0] == '--help' || args[0] == '-h');
}

void _printHelperDisplay() {
  final parser = _generateArgParser(null);
  log(parser.usage);
}

GenerateOptions _generateOption(List<String> args) {
  final generateOptions = GenerateOptions();
  _generateArgParser(generateOptions).parse(args);

  return generateOptions;
}

ArgParser _generateArgParser(GenerateOptions? generateOptions) {
  final parser = ArgParser();

  parser.addOption(
    'source-dir',
    abbr: 'S',
    defaultsTo: 'assets/styles',
    callback: (String? x) => generateOptions!.sourceDir = x,
    help: 'Folder containing styles files',
  );

  parser.addOption(
    'source-file-typography',
    abbr: 'T',
    defaultsTo: 'typography.json',
    callback: (String? x) => generateOptions!.sourceFileTypography = x,
    help: 'File to use for typography style',
  );

  parser.addOption(
    'source-file-colors',
    abbr: 'C',
    defaultsTo: 'colors.json',
    callback: (String? x) => generateOptions!.sourceFileColors = x,
    help: 'File to use for colors style',
  );

  parser.addOption(
    'output-dir',
    abbr: 'O',
    defaultsTo: 'lib/presentation/style',
    callback: (String? x) => generateOptions!.outputDir = x,
    help: 'Output folder stores for the generated file',
  );

  parser.addOption(
    'output-file-colors',
    abbr: 'c',
    defaultsTo: 'app_colors.dart',
    callback: (String? x) => generateOptions!.outputFileColors = x,
    help: 'Output file name',
  );

  parser.addOption(
    'output-file-typography',
    abbr: 't',
    defaultsTo: 'app_typography.dart',
    callback: (String? x) => generateOptions!.outputFileTypography = x,
    help: 'Output file name',
  );

  return parser;
}

class GenerateOptions {
  String? sourceDir;
  String? sourceFileColors;
  String? sourceFileTypography;
  String? templateLocale;
  String? outputDir;
  String? outputFileColors;
  String? outputFileTypography;
}

Future<void> handleStyleFiles(GenerateOptions options) async {
  final current = Directory.current;
  final source = Directory.fromUri(Uri.parse(options.sourceDir!));
  final output = Directory.fromUri(Uri.parse(options.outputDir!));
  final sourcePath = Directory(path.join(current.path, source.path));

  final outputTypographyPath = Directory(
    path.join(current.path, output.path, options.outputFileTypography),
  );

  final outputColorsPath = Directory(
    path.join(current.path, output.path, options.outputFileColors),
  );

  if (!await sourcePath.exists()) {
    printError('Source path does not exist');
    return;
  }

  var colorFiles = await dirContents(sourcePath);
  var typographyFiles = await dirContents(sourcePath);

  if (options.sourceFileColors != null) {
    final sourceFile = File(path.join(source.path, options.sourceFileColors));
    if (!await sourceFile.exists()) {
      printError('Source file does not exist (${sourceFile.toString()})');
      return;
    }
    colorFiles = [sourceFile];
  } else {
    colorFiles =
        colorFiles.where((f) => f.path.contains('colors.json')).toList();
  }

  if (options.sourceFileTypography != null) {
    final sourceFile =
        File(path.join(source.path, options.sourceFileTypography));
    if (!await sourceFile.exists()) {
      printError('Source file does not exist (${sourceFile.toString()})');
      return;
    }
    typographyFiles = [sourceFile];
  } else {
    typographyFiles = typographyFiles
        .where((f) => f.path.contains('typography.json'))
        .toList();
  }

  if (colorFiles.isNotEmpty) {
    await generateFile(
      colorFiles,
      outputColorsPath,
      'AppColors',
    );
  } else {
    printError('Source path empty');
  }

  if (colorFiles.isNotEmpty) {
    await generateFile(
      typographyFiles,
      outputTypographyPath,
      'AppTypography',
    );
  } else {
    printError('Source path empty');
  }
}

Future<List<FileSystemEntity>> dirContents(Directory dir) {
  final files = <FileSystemEntity>[];
  final completer = Completer<List<FileSystemEntity>>();

  dir.list().listen(
        files.add,
        onDone: () => completer.complete(files),
      );

  return completer.future;
}

Future<void> generateFile(
  List<FileSystemEntity> files,
  Directory outputPath,
  String className,
) async {
  final generatedFile = File(outputPath.path);
  if (!generatedFile.existsSync()) {
    generatedFile.createSync(recursive: true);
  }

  final classBuilder = StringBuffer();

  if (className == 'AppColors') {
    await _generateColorClass(classBuilder, files.first, className);
  } else {
    await _generateTypographyClass(classBuilder, files.first, className);
  }

  classBuilder.writeln('}');
  generatedFile.writeAsStringSync(classBuilder.toString());

  printInfo('All done! File generated in ${outputPath.path}');
}

Future _generateColorClass(
  StringBuffer classBuilder,
  FileSystemEntity file,
  String className,
) async {
  classBuilder.write(
    await ClassColorTemplate(
      className: className,
      file: file,
    ).generate(),
  );
}

Future _generateTypographyClass(
  StringBuffer classBuilder,
  FileSystemEntity file,
  String className,
) async {
  classBuilder.write(
    await ClassTypographyTemplate(
      className: className,
      file: file,
    ).generate(),
  );
}
