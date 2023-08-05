// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ongoing_trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OngoingTripModel _$OngoingTripModelFromJson(Map<String, dynamic> json) =>
    OngoingTripModel(
      id: json['id'] as String,
      title: json['title'] as String,
      destination: DestinationModel.fromJson(
          json['destination'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String,
      timeline: (json['timeline'] as List<dynamic>)
          .map((e) =>
              OngoingTripTimelineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OngoingTripModelToJson(OngoingTripModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'destination': instance.destination.toJson(),
      'imageUrl': instance.imageUrl,
      'timeline': instance.timeline.map((e) => e.toJson()).toList(),
      'user': instance.user.toJson(),
    };
