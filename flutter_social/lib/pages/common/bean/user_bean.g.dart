// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBean _$UserBeanFromJson(Map<String, dynamic> json) {
  return UserBean(
    json['token'] as String,
    json['userId'] as int,
    json['nickName'] as String,
    json['avatar'] as String,
    json['gender'] as int,
    json['type'] as int,
    json['phone'] as String,
  );
}

Map<String, dynamic> _$UserBeanToJson(UserBean instance) => <String, dynamic>{
      'token': instance.token,
      'userId': instance.userId,
      'nickName': instance.nickName,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'type': instance.type,
      'phone': instance.phone,
    };
