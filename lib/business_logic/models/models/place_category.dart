import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_category.g.dart';

@JsonSerializable()
class CategoryModel extends Equatable {
  final String id;
  final String title;
  final String image;
  const CategoryModel({
    required this.id,
    required this.title,
    required this.image,
  });


  @override
  List<Object?> get props => [id];

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
