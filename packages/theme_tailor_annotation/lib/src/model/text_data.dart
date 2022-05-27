/// Utility data class for creating TextStyles
class TextData {
  const TextData({
    this.fontFamily,
    this.size,
    this.lineHeight,
    this.spacing,
    this.fontWeight,
  });

  final String? fontFamily;
  final double? size;
  final double? lineHeight;
  final double? spacing;
  final int? fontWeight;
}
