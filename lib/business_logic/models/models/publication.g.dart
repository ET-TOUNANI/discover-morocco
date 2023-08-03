// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Publication _$PublicationFromJson(Map<String, dynamic> json) => Publication(
      state: $enumDecode(_$PubStateEnumMap, json['state']),
      id: json['id'] as String,
      title: json['title'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String,
      video: json['video'] as String,
      isLiked: json['isLiked'] as bool? ?? false,
      isPublished: json['isPublished'] as bool? ?? false,
      description: json['description'] as String? ?? '',
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
    );

Map<String, dynamic> _$PublicationToJson(Publication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'video': instance.video,
      'state': _$PubStateEnumMap[instance.state]!,
      'likes': instance.likes,
      'comments': instance.comments,
      'isLiked': instance.isLiked,
      'isPublished': instance.isPublished,
      'user': instance.user.toJson(),
    };

const _$PubStateEnumMap = {
  PubState.rejected: 'rejected',
  PubState.pending: 'pending',
  PubState.accepted: 'accepted',
};
