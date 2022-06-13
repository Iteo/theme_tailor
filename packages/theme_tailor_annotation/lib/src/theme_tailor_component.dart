import 'package:meta/meta_meta.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

const tailorComponent = TailorComponent();

@Target({TargetKind.classType})
class TailorComponent extends Tailor {
  const TailorComponent({
    List<String> themes = const ['light', 'dark'],
    List<ThemeEncoder> encoders = const [],
  }) : super(themes: themes, encoders: encoders, themeGetter: ThemeGetter.none);
}
