// ignore: import_of_legacy_library_into_null_safe
import 'package:json_annotation/json_annotation.dart';
part 'user_profile_bean.g.dart';

///会员信息
@JsonSerializable()
class UserProfileBean {
  int userId;
  String phone;
  String nickName;
  String avatar;
  int gender;
  int articleNum;
  int LikesNum;
  int LikedNum;

  UserProfileBean(this.userId, this.phone, this.nickName, this.avatar,
      this.gender, this.articleNum, this.LikedNum, this.LikesNum);

  /// 反序列化
  factory UserProfileBean.fromJson(Map<String, dynamic> json) =>
      _$UserProfileBeanFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$UserProfileBeanToJson(this);
}
