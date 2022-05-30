import '../models/app_typography.dart';

String toColor(String str) {
  return 'Color(0xFF${str.substring(1, 7).toString().toUpperCase()})';
}

String typographyParser(AppTypography typography) {
  final buffer = StringBuffer();

  if (typography.fontFamily != 'none') {
    buffer.write('\n    fontFamily: \'${typography.fontFamily}\',');
  }

  if (typography.fontSize != null) {
    buffer.write('\n    fontSize: ${typography.fontSize},');
  }

  if (typography.height != null) {
    buffer.write(
      '\n    height: ${toPrecision(typography.fontSize, typography.height)},',
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

double toPrecision(int? fontSize, int? lineHeight) {
  final s = ((lineHeight ?? 1) / (fontSize ?? 1)).toStringAsFixed(2);
  final returnValue = double.parse(s);
  return returnValue;
}

void printInfo(String info) {
  print('\u001b[32mTTFL: $info\u001b[0m');
}

void printError(String error) {
  print('\u001b[31m[ERROR] TTFL: $error\u001b[0m');
}
