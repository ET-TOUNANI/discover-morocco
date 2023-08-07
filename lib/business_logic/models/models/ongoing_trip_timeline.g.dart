// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ongoing_trip_timeline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OngoingTripTimelineModel _$OngoingTripTimelineModelFromJson(
        Map<String, dynamic> json) =>
    OngoingTripTimelineModel(
      id: json['id'] as String,
      date: json['date'] as String,
      done: json['done'] as bool,
      destination: DestinationModel.fromJson(
          json['destination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OngoingTripTimelineModelToJson(
        OngoingTripTimelineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'done': instance.done,
      'date': instance.date,
      'destination': instance.destination.toJson(),
    };
