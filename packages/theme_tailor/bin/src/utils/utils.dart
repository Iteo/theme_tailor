import 'dart:developer';

import '../models/app_typography.dart';

String toColor(String str) {
  return 'Color(0x${str.substring(0, 7).replaceFirst("#", str.substring(7, 9)).toUpperCase()})';
}

String typographyParser(AppTypography typography) {
  final buffer = StringBuffer();

  if (typography.fontFamily != 'none') {
    buffer.write("\nfontFamily: '${typography.fontFamily}',");
  }

  if (typography.fontSize != null) {
    buffer.write('\nfontSize: ${typography.fontSize},');
  }

  if (typography.height != null) {
    buffer.write(
      '\nheight: ${computeFontSize(typography.fontSize, typography.height)},',
    );
  }

  if (typography.fontStyle != 'none') {
    buffer.write('\nfontStyle: FontStyle.${typography.fontStyle},');
  }

  if (typography.letterSpacing != null) {
    buffer.write('\nletterSpacing: ${typography.letterSpacing},');
  }

  if (typography.fontWeight != null) {
    buffer.write('\nfontWeight: FontWeight.w${typography.fontWeight},');
  }

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
