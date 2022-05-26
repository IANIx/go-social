import 'package:flutter_social/constant/string_constant.dart';
import 'package:flutter_social/pages/common/bean/user_bean.dart';
import 'package:flutter_social/util/cache_util.dart';

import 'dart:convert' as convert;

class UserManager {
  static final UserManager _userManager = UserManager._internal();
  static bool isLogin = false;

  factory UserManager() {
    return _userManager;
  }

  UserManager._internal();

  /// 获取用户信息
  static Future<UserBean?> getUserInfo() async {
    var userString = await ESpHelper.getString(EStrings.USER_PERSON);
    if (userString == null || userString.isEmpty || userString == "null") {
      // print("[UserManager]: 用户信息为空");
      return null;
    }

    Map<String, dynamic> map = convert.jsonDecode(userString);
    // print('[UserManager]: 获取用户登录' + map.toString());

    if (map != null) {
      UserBean user = UserBean.fromJson(map);
      UserManager.isLogin = true;
      return user;
    }
    return null;
  }

  /// 获取用户id
  static Future<int?> getUserId() async {
    UserBean? user = await getUserInfo();

    if (user != null) {
      return user.userId;
    }

    return null;
  }

  /// 获取用户Token
  static Future<String?> getUserToken() async {
    UserBean? user = await getUserInfo();

    if (user != null) {
      return user.token;
    }

    return null;
  }

  /// 清除用户信息
  static clearUserInfo() {
    UserManager.isLogin = false;
    ESpHelper.set(EStrings.USER_PERSON, '');
  }
}
