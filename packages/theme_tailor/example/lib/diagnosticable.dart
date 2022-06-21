/// Import flutter foundation to generate debugFillProperties
import 'package:example/diagnosticable_lib.dart';

part 'diagnosticable.tailor.dart';

@tailor
class _$MyTheme {
  static List<Color> background = [Colors.white, Colors.black];
  static List<Color> iconColor = [Colors.orange, Colors.blue];
  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];
  static List<TextStyle> h2 = const [TextStyle(), TextStyle()];
}
