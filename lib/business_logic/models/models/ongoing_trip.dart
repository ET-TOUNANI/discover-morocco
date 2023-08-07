import 'package:discover_morocco/business_logic/models/authentication/models/models.dart';
import 'package:discover_morocco/business_logic/models/models/destination.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ongoing_trip_timeline.dart';

part 'ongoing_trip.g.dart';

@JsonSerializable(explicitToJson: true)
class OngoingTripModel extends Equatable {
  final String id;
  final List<OngoingTripTimelineModel> timeline;

  const OngoingTripModel({
    required this.id,
    required this.timeline
  });

  @override
  List<Object?> get props => [id];

  factory OngoingTripModel.fromJson(Map<String, dynamic> json) =>
      _$OngoingTripModelFromJson(json);

  Map<String, dynamic> toJson() => _$OngoingTripModelToJson(this);
}