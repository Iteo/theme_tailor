import 'package:test/test.dart';
import 'package:theme_tailor/src/util/string_util.dart';

void main() {
  const _getterTestData = <String, String?>{
    'List<TextStyle> get h2 => const [TextStyle(), TextStyle()];': 'h2',
    'List<Color> get appBar => [AppColors.orange, AppColors.blue];': 'appBar',
    'List<Color?> get appBar => [AppColors.orange, AppColors.blue];': 'appBar',
    'List<Color> get surface => lol;': 'surface',
    'List<Color> get background =>[AppColors.white, AppColors.black];': 'background',
    'Nogetterhere': null,
    'Holy pancakes 123': null,
  };

  const _listTypeTestData = <String, String?>{
    'List<TextStyle> get h2 => const [TextStyle(), TextStyle()];': 'TextStyle',
    'List<Color> get appBar => [AppColors.orange, AppColors.blue];': 'Color',
    'List<Color?> get appBar => [AppColors.orange, AppColors.blue];': 'Color?',
    'List<Color> get surface => lol;': 'Color',
    'List<Color> get background =>[AppColors.white, AppColors.black];': 'Color',
    'Nogetterhere': null,
    'Holy pancakes 123': null,
  };

  test('isGetter', () {
    const stringUtil = StringUtil();
    _getterTestData.forEach((k, v) => expect(stringUtil.isGetter(k), v != null));
  });

  test('getGetterName', () {
    const stringUtil = StringUtil();
    _getterTestData.forEach((k, v) => expect(stringUtil.getGetterName(k), v));
  });

  test('isListType', () {
    const stringUtil = StringUtil();
    _listTypeTestData.forEach((k, v) => expect(stringUtil.isListType(k), v != null));
  });

  test('getTypeFromList', () {
    const stringUtil = StringUtil();
    _listTypeTestData.forEach((k, v) => expect(stringUtil.getTypeFromList(k), v));
  });
}
