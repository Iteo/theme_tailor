import 'package:source_gen_test/source_gen_test.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

@ShouldThrow('@TailorMixin can only annotate classes')
// ignore: invalid_annotation_target
@TailorMixin()
enum WrongAnnotationTarget {
  wrongTarget;
}

@ShouldGenerate(
  'return CtorRequiredParametes(propA ?? this.propA, propB ?? this.propB);',
  contains: true,
)
@TailorMixin(themeGetter: ThemeGetter.none)
class CtorRequiredParametes {
  const CtorRequiredParametes(this.propA, this.propB);

  final int propA;
  final int propB;
}

@ShouldGenerate(
  'return CtorPositionalParameters(propA ?? this.propA, propB ?? this.propB);',
  contains: true,
)
@TailorMixin(themeGetter: ThemeGetter.none)
class CtorPositionalParameters {
  const CtorPositionalParameters(this.propA, [this.propB = 0]);

  final int propA;
  final int propB;
}

@ShouldGenerate(
  'return CtorNamedParameters(propA ?? this.propA, propB: propB ?? this.propB);',
  contains: true,
)
@TailorMixin(themeGetter: ThemeGetter.none)
class CtorNamedParameters {
  const CtorNamedParameters(this.propA, {required this.propB});

  final int propA;
  final int propB;
}

@ShouldGenerate(
  '''
extension OnBuildContextBuildContext on BuildContext {
  OnBuildContext get onBuildContext =>
      Theme.of(this).extension<OnBuildContext>()!;
}
''',
  contains: true,
)
@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class OnBuildContext {
  OnBuildContext({required this.prop});

  final int prop;
}

@ShouldGenerate(
  '''
extension OnBuildContextPropsBuildContextProps on BuildContext {
  OnBuildContextProps get onBuildContextProps =>
      Theme.of(this).extension<OnBuildContextProps>()!;
  int get prop => onBuildContextProps.prop;
}
''',
  contains: true,
)
@TailorMixin(themeGetter: ThemeGetter.onBuildContextProps)
class OnBuildContextProps {
  OnBuildContextProps({required this.prop});

  final int prop;
}

@ShouldGenerate(
  '''
extension OnThemeDataThemeData on ThemeData {
  OnThemeData get onThemeData => extension<OnThemeData>()!;
}
''',
  contains: true,
)
@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class OnThemeData {
  OnThemeData({required this.prop});

  final int prop;
}

@ShouldGenerate(
  '''
extension OnThemeDataPropsThemeDataProps on ThemeData {
  OnThemeDataProps get onThemeDataProps => extension<OnThemeDataProps>()!;
  int get prop => onThemeDataProps.prop;
}
''',
  contains: true,
)
@TailorMixin(themeGetter: ThemeGetter.onThemeDataProps)
class OnThemeDataProps {
  OnThemeDataProps(this.prop);

  final int prop;
}

@ShouldGenerate(r'''
mixin _$SomeClassTailorMixin on ThemeExtension<SomeClass> {
  int get prop;

  @override
  SomeClass copyWith({int? prop}) {
    return SomeClass(prop: prop ?? this.prop);
  }

  @override
  SomeClass lerp(covariant ThemeExtension<SomeClass>? other, double t) {
    if (other is! SomeClass) return this as SomeClass;
    return SomeClass(prop: t < 0.5 ? prop : other.prop);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SomeClass &&
            const DeepCollectionEquality().equals(prop, other.prop));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(prop),
    );
  }
}
''')
@TailorMixin(themeGetter: ThemeGetter.none)
class SomeClass {
  const SomeClass({required this.prop});

  final int prop;
}
