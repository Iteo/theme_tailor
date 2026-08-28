import 'package:example/diagnosticable_lib.dart';
part 'primary_constructor.tailor.dart';

final class PrimaryConstructorColorEncoder extends ThemeEncoder<Color> {
  const PrimaryConstructorColorEncoder();

  static const Color color = Color(0xFF00FF00);

  @override
  Color lerp(Color a, Color b, double t) => color;
}

final class PrimaryConstructorNullableColorEncoder
    extends ThemeEncoder<Color?> {
  const PrimaryConstructorNullableColorEncoder();

  @override
  Color? lerp(Color? a, Color? b, double t) => PrimaryConstructorColorEncoder.color;
}

final class PrimaryConstructorTextStyleEncoder extends ThemeEncoder<TextStyle> {
  const PrimaryConstructorTextStyleEncoder();

  @override
  TextStyle lerp(TextStyle a, TextStyle b, double t) =>
      const TextStyle(color: PrimaryConstructorColorEncoder.color);
}

@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
@PrimaryConstructorTextStyleEncoder()
@PrimaryConstructorColorEncoder()
class PrimaryConstructor(
  @override final Color color,
  @override final TextStyle text,
  @PrimaryConstructorNullableColorEncoder() @override var Color? nullableColor,
) extends ThemeExtension<PrimaryConstructor>
    with _$PrimaryConstructorTailorMixin;

@tailorMixinComponent
class PrimaryConstructor2({
  @override required final Color color,
  @override required final TextStyle text,
  @override final Color? nullableColor,
}) extends ThemeExtension<PrimaryConstructor2>
    with _$PrimaryConstructor2TailorMixin;
