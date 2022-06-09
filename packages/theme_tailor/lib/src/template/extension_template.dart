import 'package:theme_tailor/src/model/theme_class_config.dart';
import 'package:theme_tailor/src/util/util.dart';

class ThemeExtensionTemplate {
  const ThemeExtensionTemplate(this._config, this._fmt);

  final FMTString _fmt;
  final ThemeClassConfig _config;

  String get _classGetter {
    final name = _config.returnType;
    final getterName = _fmt.asCammelCase(name);

    return name != getterName ? getterName : '${getterName}Extension';
  }

  String get _privateClassGetter => _fmt.asPrivateAccessor(_classGetter);

  String get _classType => _config.returnType;

  String _gettersOnThemeData() {
    return '''
    extension ${_classType}ThemeDataExtension on ThemeData {
      $_classType get $_classGetter => extension<$_classType>()!;
    }
    ''';
  }

  String _gettersOnThemeDataProps() {
    final themeGetterName = _privateClassGetter;
    final getters = _config.fields.entries
        .map((e) =>
            '${e.value.typeStr} get ${e.key} => $themeGetterName.${e.key}')
        .join(';');

    return '''
    extension ${_classType}ThemeDataExtension on ThemeData {
      $_classType get $themeGetterName => extension<$_classType>()!;
      $getters;
    } 
    ''';
  }

  String _gettersOnBuildContext() {
    return '''
    extension ${_classType}BuildContextExtension on BuildContext {
      $_classType get $_classGetter => Theme.of(this).extension<$_classType>()!;
    }
    ''';
  }

  String _gettersOnBuildContextProps() {
    final themeGetterName = _privateClassGetter;
    final getters = _config.fields.entries
        .map((e) =>
            '${e.value.typeStr} get ${e.key} => $themeGetterName.${e.key}')
        .join(';');

    return '''
    extension ${_classType}BuildContextExtension on BuildContext {
      $_classType get $themeGetterName => Theme.of(this).extension<$_classType>()!;
      $getters;
    } 
    ''';
  }

  @override
  String toString() {
    return _config.themeGetter.maybeWhen(
      onThemeData: _gettersOnThemeData,
      onThemeDataProps: _gettersOnThemeDataProps,
      onBuildContext: _gettersOnBuildContext,
      onBuildContextProps: _gettersOnBuildContextProps,
      orElse: () => '',
    );
  }
}
