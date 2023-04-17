import 'package:source_gen_test/source_gen_test.dart';
import 'package:theme_tailor/src/generator/tailor_mixin_generator.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

Future<void> main() async {
  initializeBuildLogTracking();

  final reader = await initializeLibraryReaderForDirectory(
    'test/code_gen/inputs',
    'tailor_mixin_test_input.dart',
  );

  testAnnotatedElements(reader, TailorMixinGenerator(Tailor()));
}
