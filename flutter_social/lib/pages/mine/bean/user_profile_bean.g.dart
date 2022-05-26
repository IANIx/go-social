// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileBean _$UserProfileBeanFromJson(Map<String, dynamic> json) {
  return UserProfileBean(
    json['userId'] as int,
    json['phone'] as String,
    json['nickName'] as String,
    json['avatar'] as String,
    json['gender'] as int,
    json['articleNum'] as int,
    json['LikedNum'] as int,
    json['LikesNum'] as int,
  );
}

Map<String, dynamic> _$UserProfileBeanToJson(UserProfileBean instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'phone': instance.phone,
      'nickName': instance.nickName,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'articleNum': instance.articleNum,
      'LikesNum': instance.LikesNum,
      'LikedNum': instance.LikedNum,
    };
