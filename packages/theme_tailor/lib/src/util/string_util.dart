class FMTString {
  const FMTString();

  String formatClassName(String val) {
    return val.replaceFirst(r'_$', '').replaceFirst(r'$_', '');
  }

  String asCammelCase(String val) {
    return val.isEmpty ? val : val[0].toLowerCase() + val.substring(1);
  }

  String asPrivateAccessor(String val) {
    return val.isEmpty ? val : '_$val';
  }
}
