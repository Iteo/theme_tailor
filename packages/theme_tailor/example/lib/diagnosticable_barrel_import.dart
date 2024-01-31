// ignore_for_file: annotate_overrides

/// Import flutter foundation to generate debugFillProperties
import 'package:example/diagnosticable_lib.dart';

part 'diagnosticable_barrel_import.tailor.dart';

@TailorMixin()
class MyTheme extends ThemeExtension<MyTheme>
    with DiagnosticableTreeMixin, _$MyThemeTailorMixin {
  MyTheme({
    required this.background,
    required this.textStyle,
  });

  final Color background;
  final TextStyle textStyle;
}
