import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../models/ongoing_trip.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends Equatable {
  const UserModel({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.phone,
    this.fcmToken,
    this.isAnonymous,
    this.emailVerified,
    this.trip,
  });

  final String id;
  final String? email;
  final String? name;
  final String? photo;
  final String? phone;
  final bool? isAnonymous;
  final bool? emailVerified;
  final String? fcmToken;
  final OngoingTripModel? trip;

  /// Empty user which represents an unauthenticated user.
  static const empty = UserModel(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [email, id, name, photo];

  @override
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
