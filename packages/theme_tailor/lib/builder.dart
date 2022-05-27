import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generator/theme_tailor_generator.dart';

Builder themeTailorBuilder(BuilderOptions options) {
  return LibraryBuilder(
    ThemeTailorGenerator(),
    generatedExtension: '.tailor.dart',
  );
}
