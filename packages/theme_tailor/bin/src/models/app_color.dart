import 'package:json_annotation/json_annotation.dart';

part 'app_color.g.dart';

@JsonSerializable()
class AppColor {
  AppColor({
    this.color,
    this.name,
    this.parent,
    this.description,
  });

  final String? color;
  final String? name;
  final String? parent;
  final String? description;

  factory AppColor.fromJson(Map<String, dynamic> json) =>
      _$AppColorFromJson(json);

  Map<String, dynamic> toJson() => _$AppColorToJson(this);

  AppColor copyWith({
    String? color,
    String? name,
    String? parent,
    String? description,
  }) {
    return AppColor(
      color: color ?? this.color,
      name: name ?? this.name,
      parent: parent ?? this.parent,
      description: description ?? this.description,
    );
  }
}
