import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  @JsonKey(name: 'idCategory')
  String id;
  @JsonKey(name: 'strCategory')
  String name;
  @JsonKey(name: 'strCategoryThumb')
  String? imageUrl;
  @JsonKey(name: 'strCategoryDescription')
  String? description;

  Category({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
