import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldThrow(
  'Field "s1" needs to be a const in order to be included',
)
@Tailor(
  themes: ['light'],
  requireStaticConst: true,
)
class $_ThrowErrorOnFinalIncluded {
  static final s1 = ['blue'];
  static const s2 = ['red'];
}

@ShouldGenerate(
  r'''
class GenerateConstantTheme extends ThemeExtension<GenerateConstantTheme> {
  const GenerateConstantTheme({
    required this.s1,
    required this.s2,
  });

  final String s1;
  final String s2;

  static const GenerateConstantTheme light = GenerateConstantTheme(
    s1: 'blue',
    s2: 'red',
  );

  static const themes = [
    light,
  ];

  @override
  GenerateConstantTheme copyWith({
    String? s1,
    String? s2,
  }) {
    return GenerateConstantTheme(
      s1: s1 ?? this.s1,
      s2: s2 ?? this.s2,
    );
  }

  @override
  GenerateConstantTheme lerp(
      ThemeExtension<GenerateConstantTheme>? other, double t) {
    if (other is! GenerateConstantTheme) return this;
    return GenerateConstantTheme(
      s1: t < 0.5 ? s1 : other.s1,
      s2: t < 0.5 ? s2 : other.s2,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenerateConstantTheme &&
            const DeepCollectionEquality().equals(s1, other.s1) &&
            const DeepCollectionEquality().equals(s2, other.s2));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, const DeepCollectionEquality().hash(s1),
        const DeepCollectionEquality().hash(s2));
  }
}
''',
)
@Tailor(
  themes: ['light'],
  requireStaticConst: true,
  themeGetter: ThemeGetter.none,
)
class $_GenerateConstantTheme {
  static const s1 = ['blue'];
  static const s2 = ['red'];
}

@ShouldGenerate(
  r'''static const GenerateConstantOverGetters light = GenerateConstantOverGetters(
    s1: 'blue',
    s2: 'red',
  );''',
  contains: true,
)
@Tailor(
  themes: ['light'],
  requireStaticConst: true,
  generateStaticGetters: true,
)
class $_GenerateConstantOverGetters {
  static const s1 = ['blue'];
  static const s2 = ['red'];
}

@ShouldGenerate(
  'static GenerateGetters get light => kDebugMode ? _lightGetter : _lightFinal;',
  contains: true,
)
@Tailor(
  themes: ['light'],
)
class $_GenerateGetters {
  static const s1 = ['blue'];
  static List<String> get s2 => ['red'];
}

@ShouldGenerate(
  'static final GenerateFinalsOnUnsupportedKeywordIncluded light',
  contains: true,
)
@Tailor(
  themes: ['light'],
  generateStaticGetters: false,
)
class $_GenerateFinalsOnUnsupportedKeywordIncluded {
  static const s1 = ['blue'];
  static List<String> s2 = ['red'];
}
