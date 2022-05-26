// ignore: import_of_legacy_library_into_null_safe
import 'package:json_annotation/json_annotation.dart';
part 'user_bean.g.dart';

///会员信息
@JsonSerializable()
class UserBean {
  String token;
  int userId;
  String nickName;
  String avatar;
  int gender;
  int type;
  String phone;

  UserBean(this.token, this.userId, this.nickName, this.avatar, this.gender,
      this.type, this.phone);

  /// 反序列化
  factory UserBean.fromJson(Map<String, dynamic> json) =>
      _$UserBeanFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$UserBeanToJson(this);
}
