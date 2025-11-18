import 'package:example/assets.dart';
import 'package:example/diagnosticable_lib.dart';
import 'package:example/gen/assets.gen.dart';

part 'style.tailor.dart';

class AssetGenNullableEncoder extends ThemeEncoder<AssetGenImage> {
  const AssetGenNullableEncoder();

  @override
  AssetGenImage lerp(AssetGenImage a, AssetGenImage b, double t) => b;
}

@TailorMixin()
class LogoStyle extends ThemeExtension<LogoStyle> with _$LogoStyleTailorMixin {
  LogoStyle({required this.asset});

  @AssetGenNullableEncoder()
  final AssetGenImage asset;
}
