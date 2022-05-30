extension StringExtension on String {
  String formatClassName() => replaceFirst(r'_$', '');
}
