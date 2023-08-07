import 'package:discover_morocco/business_logic/models/models/destination.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ongoing_trip_timeline.g.dart';

@JsonSerializable(explicitToJson: true)
class OngoingTripTimelineModel extends Equatable {
  final String id;
  final bool done;
  final String date;
  final DestinationModel destination;

  const OngoingTripTimelineModel( {
    required this.id,
    required this.date,
    required this.done,
    required this.destination
  });

  @override
  List<Object?> get props => [id];

  factory OngoingTripTimelineModel.fromJson(Map<String, dynamic> json) =>
      _$OngoingTripTimelineModelFromJson(json);

  Map<String, dynamic> toJson() => _$OngoingTripTimelineModelToJson(this);
}
