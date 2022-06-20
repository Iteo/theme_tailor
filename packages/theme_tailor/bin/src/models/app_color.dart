import 'package:json_annotation/json_annotation.dart';

part 'app_color.g.dart';

@JsonSerializable()
class AppColor {
  factory AppColor.fromJson(Map<String, dynamic> json) =>
      _$AppColorFromJson(json);

  AppColor({
    this.color,
    this.name,
    this.parent,
    this.description,
    this.isDark = false,
  });

  final String? color;
  final String? name;
  final String? parent;
  final String? description;
  final bool isDark;

  Map<String, dynamic> toJson() => _$AppColorToJson(this);

  AppColor copyWith({
    String? color,
    String? name,
    String? parent,
    String? description,
    bool? isDark,
  }) {
    return AppColor(
      color: color ?? this.color,
      name: name ?? this.name,
      parent: parent ?? this.parent,
      description: description ?? this.description,
      isDark: isDark ?? this.isDark,
    );
  }
}
