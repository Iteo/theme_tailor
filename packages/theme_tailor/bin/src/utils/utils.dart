import 'dart:developer';

import '../models/app_typography.dart';

String toColor(String str) {
  return 'Color(0x${str.substring(0, 7).replaceFirst("#", str.substring(7, 9)).toUpperCase()})';
}

String typographyParser(AppTypography typography) {
  final buffer = StringBuffer();

  if (typography.fontFamily != 'none') {
    buffer.writeln("fontFamily: '${typography.fontFamily}',");
  }

  if (typography.fontSize != null) {
    buffer.writeln('fontSize: ${typography.fontSize},');
  }

  if (typography.height != null) {
    buffer.writeln(
      'height: ${computeFontSize(typography.fontSize, typography.height)},',
    );
  }

  if (typography.fontStyle != 'none') {
    buffer.writeln('fontStyle: FontStyle.${typography.fontStyle},');
  }

  if (typography.letterSpacing != null) {
    buffer.writeln('letterSpacing: ${typography.letterSpacing},');
  }

  if (typography.fontWeight != null) {
    buffer.writeln('fontWeight: FontWeight.w${typography.fontWeight},');
  }

  if (typography.decoration != null) {
    var decoration = "TextDecoration.none";

    switch (typography.decoration) {
      case "underline":
        decoration = "TextDecoration.underline";
        break;
      case "overline":
        decoration = "TextDecoration.overline";
        break;
      case "line-through":
        decoration = "TextDecoration.lineThrough";
        break;
      default:
        decoration = "TextDecoration.none";
    }

    buffer.writeln('decoration: $decoration,');
  }

  buffer.writeln('debugLabel: "${typography.name}",');

  return buffer.toString();
}

double computeFontSize(int? fontSize, int? lineHeight) {
  return ((lineHeight ?? 1) / (fontSize ?? 1));
}

void printInfo(String info) {
  log('\u001b[32mTTFL: $info\u001b[0m');
}

void printError(String error) {
  log('\u001b[31m[ERROR] TTFL: $error\u001b[0m');
}
