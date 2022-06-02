import 'package:test/test.dart';
import 'package:theme_tailor/src/util/regexp.dart';

void main() {
  test('findGetterName', () {
    <String, String?>{
      'List<TextStyle> get h2 => const [TextStyle(), TextStyle()];': 'h2',
      'List<Color> get appBar => [AppColors.orange, AppColors.blue];': 'appBar',
      'List<Color> get surface => lol;': 'surface',
      'List<Color> get background =>[AppColors.white, AppColors.black];': 'background',
      'Nogetterhere': null,
      'Holy pancakes 123': null,
    }.forEach((k, v) => expect(findGetterName(k), v));
  });
}
