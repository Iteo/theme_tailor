import 'package:theme_tailor/src/model/theme_class_config.dart';

class ThemeExtensionTemplate {
  const ThemeExtensionTemplate(this.config);

  final ThemeClassConfig config;

  String _gettersOnThemeData() {
    return '''
    extension ${config.returnType}ThemeDataExtension on ThemeData {
      ${config.returnType} get ${config.returnType.camelCase} => extension<${config.returnType}>()!;
    }
    ''';
  }

  String _gettersOnThemeDataProps() {
    final themeGetterName = config.returnType.camelCase.asPrivateVariable;
    final getters = config.fields.entries
        .map((e) =>
            '${e.value.typeStr} get ${e.key} => $themeGetterName.${e.key}')
        .join(';');

    return '''
    extension ${config.returnType}ThemeDataExtension on ThemeData {
      ${config.returnType} get $themeGetterName => extension<${config.returnType}>()!;
      $getters;
    } 
    ''';
  }

  String _gettersOnBuildContext() {
    return '''
    extension ${config.returnType}BuildContextExtension on BuildContext {
      ${config.returnType} get ${config.returnType.camelCase} => Theme.of(this).extension<${config.returnType}>()!;
    }
    ''';
  }

  String _gettersOnBuildContextProps() {
    final themeGetterName = config.returnType.camelCase.asPrivateVariable;
    final getters = config.fields.entries
        .map((e) =>
            '${e.value.typeStr} get ${e.key} => $themeGetterName.${e.key}')
        .join(';');

    return '''
    extension ${config.returnType}BuildContextExtension on BuildContext {
      ${config.returnType} get $themeGetterName => Theme.of(this).extension<${config.returnType}>()!;
      $getters;
    } 
    ''';
  }

  @override
  String toString() {
    return config.themeGetter.maybeWhen(
      onThemeData: _gettersOnThemeData,
      onThemeDataProps: _gettersOnThemeDataProps,
      onBuildContext: _gettersOnBuildContext,
      onBuildContextProps: _gettersOnBuildContextProps,
      orElse: () => '',
    );
  }
}

extension on String {
  String get camelCase => isEmpty ? this : this[0].toLowerCase() + substring(1);
  String get asPrivateVariable => isEmpty ? this : '_$this';
}
