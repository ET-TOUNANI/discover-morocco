// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ongoing_trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OngoingTripModel _$OngoingTripModelFromJson(Map<String, dynamic> json) =>
    OngoingTripModel(
      id: json['id'] as String,
      timeline: (json['timeline'] as List<dynamic>)
          .map((e) =>
              OngoingTripTimelineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OngoingTripModelToJson(OngoingTripModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeline': instance.timeline.map((e) => e.toJson()).toList(),
    };
