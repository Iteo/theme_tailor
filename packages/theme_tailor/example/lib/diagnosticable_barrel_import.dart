/// Import flutter foundation to generate debugFillProperties
import 'package:example/diagnosticable_lib.dart';

part 'diagnosticable_barrel_import.tailor.dart';

@Tailor(generateStaticGetters: false)
class _$MyTheme {
  static List<Color> background = [Colors.white, Colors.black];
  static List<TextStyle> textStyle = const [TextStyle(), TextStyle()];
}
