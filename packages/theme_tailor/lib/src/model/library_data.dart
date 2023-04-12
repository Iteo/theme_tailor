class ImportsData {
  const ImportsData({
    required this.hasJsonSerializable,
    required this.hasFlutterDiagnosticable,
  });

  final bool hasJsonSerializable;
  final bool hasFlutterDiagnosticable;
}

class TailorMixinImports {
  const TailorMixinImports({required this.hasFlutterDiagnosticable});

  final bool hasFlutterDiagnosticable;
}
