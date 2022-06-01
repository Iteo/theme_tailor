import '../models/app_typography.dart';

String toColor(String str) {
  return 'Color(0x${str.substring(0, 7).replaceFirst("#", str.substring(7, 9)).toUpperCase()})';
}

String typographyParser(AppTypography typography) {
  final buffer = StringBuffer();

  if (typography.fontFamily != 'none') {
    buffer.write("\n    fontFamily: '${typography.fontFamily}',");
  }

  if (typography.fontSize != null) {
    buffer.write('\n    fontSize: ${typography.fontSize},');
  }

  if (typography.height != null) {
    buffer.write(
      '\n    height: ${computeFontSize(typography.fontSize, typography.height)},',
    );
  }

  if (typography.fontStyle != 'none') {
    buffer.write('\n    fontStyle: FontStyle.${typography.fontStyle},');
  }

  if (typography.letterSpacing != null) {
    buffer.write('\n    letterSpacing: ${typography.letterSpacing},');
  }

  if (typography.fontWeight != null) {
    buffer.write('\n    fontWeight: FontWeight.w${typography.fontWeight},');
  }

  return buffer.toString();
}

double computeFontSize(int? fontSize, int? lineHeight) {
  return ((lineHeight ?? 1) / (fontSize ?? 1));
}

void printInfo(String info) {
  print('\u001b[32mTTFL: $info\u001b[0m');
}

void printError(String error) {
  print('\u001b[31m[ERROR] TTFL: $error\u001b[0m');
}
