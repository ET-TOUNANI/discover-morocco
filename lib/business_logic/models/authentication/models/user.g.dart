// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      phone: json['phone'] as String?,
      fcmToken: json['fcmToken'] as String?,
      isAnonymous: json['isAnonymous'] as bool?,
      trip: json['trip'] == null
          ? null
          : OngoingTripModel.fromJson(json['trip'] as Map<String, dynamic>),
      emailVerified: json['emailVerified'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'photo': instance.photo,
      'phone': instance.phone,
      'trip': instance.trip?.toJson(),
      'isAnonymous': instance.isAnonymous,
      'emailVerified': instance.emailVerified,
      'fcmToken': instance.fcmToken,
    };
