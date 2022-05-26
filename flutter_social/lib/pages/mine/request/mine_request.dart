import 'package:flutter_social/network/http_request.dart';
import 'package:flutter_social/pages/mine/bean/user_profile_bean.dart';
import 'package:flutter_social/util/toast_util.dart';

class MineRequest {
  /// jwt
  static Future<bool> jwt() async {
    String url = await EHttpRequest.url("/v1/user/jwt_info");

    Map parameters = {};

    return EHttpRequest.post(url, parameters: parameters, onSuccess: (data) {},
        onError: (error) {
      showToast(error);
    });
  }

  static Future<bool> profile({
    RequestDataCallBack<UserProfileBean>? dataCallBack,
  }) async {
    String url = await EHttpRequest.url("/v1/user/profile");

    Map parameters = {};

    return EHttpRequest.post(url, parameters: parameters, onSuccess: (data) {
      if (dataCallBack != null) {
        var d = data as Map<String, dynamic>?;

        if (d != null) {
          UserProfileBean bean = UserProfileBean.fromJson(d);
          dataCallBack(bean, null);
        } else {
          dataCallBack(null, "数据解析失败");
        }
      }
    }, onError: (error) {
      showToast(error);
      if (dataCallBack != null) {
        dataCallBack(null, error);
      }
    });
  }

  /// 退出登录
  static Future<bool> logout({
    RequestDataCallBack<bool>? dataCallBack,
  }) async {
    String url = await EHttpRequest.url("/v1/user/logout");

    Map parameters = {};

    return EHttpRequest.post(url, parameters: parameters, onSuccess: (data) {
      if (dataCallBack != null) {
        dataCallBack(true, null);
      }
    }, onError: (error) {
      showToast(error);
      if (dataCallBack != null) {
        dataCallBack(null, error);
      }
    });
  }
}
