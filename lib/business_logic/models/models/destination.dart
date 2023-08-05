import 'package:discover_morocco/business_logic/models/models/place_category.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'destination.g.dart';

@JsonSerializable(explicitToJson: true)
class DestinationModel extends Equatable {
  final String id;
  final String city;
  final List<CategoryModel> categories;

   const DestinationModel({
    required this.id,
    required this.city,
     required this.categories
  });

  @override
  List<Object?> get props => [id];

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      _$DestinationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationModelToJson(this);
}
