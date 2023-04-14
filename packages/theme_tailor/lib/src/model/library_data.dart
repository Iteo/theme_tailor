class ImportsData {
  const ImportsData({
    bool? hasJsonSerializable,
    bool? hasDiagnosticableMixin,
  })  : hasJsonSerializable = hasJsonSerializable ?? false,
        hasDiagnosticableMixin = hasDiagnosticableMixin ?? false;

  final bool hasJsonSerializable;
  final bool hasDiagnosticableMixin;
}
