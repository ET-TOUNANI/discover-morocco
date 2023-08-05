import 'package:discover_morocco/business_logic/models/authentication/models/models.dart';
import 'package:discover_morocco/business_logic/models/models/destination.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ongoing_trip_timeline.dart';

part 'ongoing_trip.g.dart';

@JsonSerializable(explicitToJson: true)
class OngoingTripModel extends Equatable {
  final String id;
  final String title;
  final DestinationModel destination;
  final String imageUrl;
  final List<OngoingTripTimelineModel> timeline;
  final UserModel user;

  const OngoingTripModel({
    required this.id,
    required this.title,
    required this.destination,
    required this.imageUrl,
    required this.timeline,
    required this.user,
  });

  @override
  List<Object?> get props => [id];

  factory OngoingTripModel.fromJson(Map<String, dynamic> json) =>
      _$OngoingTripModelFromJson(json);

  Map<String, dynamic> toJson() => _$OngoingTripModelToJson(this);
}
