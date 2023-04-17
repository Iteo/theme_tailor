import 'package:source_gen_test/source_gen_test.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

@ShouldThrow('@TailorMixin can only annotate classes')
// ignore: invalid_annotation_target
@TailorMixin()
enum WrongAnnotationTarget {
  wrongTarget;
}

@ShouldGenerate('''
extension OnBuildContextBuildContext on BuildContext {
  OnBuildContext get onBuildContext =>
      Theme.of(this).extension<OnBuildContext>()!;
}
''', contains: true)
@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class OnBuildContext {
  OnBuildContext(this.prop1);

  final int prop1;
}

@ShouldGenerate('''
extension OnBuildContextPropsBuildContextProps on BuildContext {
  OnBuildContextProps get onBuildContextProps =>
      Theme.of(this).extension<OnBuildContextProps>()!;
  int get prop1 => onBuildContextProps.prop1;
}
''', contains: true)
@TailorMixin(themeGetter: ThemeGetter.onBuildContextProps)
class OnBuildContextProps {
  OnBuildContextProps(this.prop1);

  final int prop1;
}

@ShouldGenerate('''
extension OnThemeDataThemeData on ThemeData {
  OnThemeData get onThemeData => extension<OnThemeData>()!;
}
''', contains: true)
@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class OnThemeData {
  OnThemeData(this.prop1);

  final int prop1;
}

@ShouldGenerate('''
extension OnThemeDataPropsThemeDataProps on ThemeData {
  OnThemeDataProps get onThemeDataProps => extension<OnThemeDataProps>()!;
  int get prop1 => onThemeDataProps.prop1;
}
''', contains: true)
@TailorMixin(themeGetter: ThemeGetter.onThemeDataProps)
class OnThemeDataProps {
  OnThemeDataProps(this.prop1);

  final int prop1;
}

@ShouldGenerate(r'''
mixin _$SomeClassTailorMixin on ThemeExtension<SomeClass> {
  int get prop1;

  @override
  SomeClass copyWith({
    int? prop1,
  }) {
    return SomeClass(
      prop1: prop1 ?? this.prop1,
    );
  }

  @override
  SomeClass lerp(covariant ThemeExtension<SomeClass>? other, double t) {
    if (other is! SomeClass) return this as SomeClass;
    return SomeClass(
      prop1: t < 0.5 ? prop1 : other.prop1,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SomeClass &&
            const DeepCollectionEquality().equals(prop1, other.prop1));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(prop1),
    );
  }
}
''')
@TailorMixin(themeGetter: ThemeGetter.none)
class SomeClass {
  const SomeClass({required this.prop1});

  final int prop1;
}
