import 'package:discover_morocco/business_logic/models/authentication/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'enums/PubState.dart';

part 'publication.g.dart';

@JsonSerializable(explicitToJson: true)
class Publication extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String imageUrl;
  final String video;
  final PubState state;

  final int likes;
  final int comments;
  final bool isLiked;
  final bool isPublished;
  final UserModel user;

  const Publication({
    required this.state,
    required this.id,
    required this.title,
    required this.user,
    required this.imageUrl,
    required this.video,
    this.isLiked = false,
    this.isPublished = false,
    this.description = '',
    this.likes = 0,
    this.comments = 0,
  });

  @override
  List<Object?> get props => [id];

  factory Publication.fromJson(Map<String, dynamic> json) =>
      _$PublicationFromJson(json);

  Map<String, dynamic> toJson() => _$PublicationToJson(this);
}
