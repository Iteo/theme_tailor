import 'package:test/test.dart';
import 'package:theme_tailor/src/util/string_util.dart';

void main() {
  const _getterTestData = <String, String?>{
    'List<TextStyle> get h2 => const [TextStyle(), TextStyle()];': null,
    'List<Color> get appBar => [AppColors.orange, AppColors.blue];': null,
    'List<Color?> get appBar => [AppColors.orange, AppColors.blue];': null,
    'List<Color> get surface => lol;': null,
    'List<Color> get background =>[AppColors.white, AppColors.black];': null,
    'Nogetterhere': null,
    'Holy pancakes 123': null,
    'static List<Color> background3 = [AppColors.white, AppColors.black];': 'background3',
    'static List<Color>surface=lol3;': 'surface',
    'static List<Color>appBar3 = [AppColors.orange, AppColors.blue];': 'appBar3',
    'static List<TextStyle> a = const [TextStyle(), TextStyle()];': 'a',
    'static List<TextStyle> b= const [TextStyle(), TextStyle()];': 'b',
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

  test('isField', () {
    const stringUtil = StringUtil();
    _getterTestData.forEach((k, v) => expect(stringUtil.isField(k), v != null));
  });

  test('getFieldName', () {
    const stringUtil = StringUtil();
    _getterTestData.forEach((k, v) => expect(stringUtil.getFieldName(k), v));
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
