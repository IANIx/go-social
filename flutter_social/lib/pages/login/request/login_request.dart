import 'package:flutter_social/network/http_request.dart';
import 'package:flutter_social/pages/common/bean/user_bean.dart';
import 'package:flutter_social/util/toast_util.dart';

class LoginRequest {
  /// 登录
  static Future<bool> login({
    required String phone,
    required String password,
    RequestDataCallBack<UserBean>? dataCallBack,
  }) async {
    String url = await EHttpRequest.url("/v1/user/login");

    Map parameters = {"phone": phone, "password": password};

    return EHttpRequest.post(url, parameters: parameters, onSuccess: (data) {
      if (dataCallBack != null) {
        var d = data as Map<String, dynamic>?;

        if (d != null) {
          UserBean bean = UserBean.fromJson(d);
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

  /// 注册
  static Future<bool> register({
    required String phone,
    required String password,
    required String password2,
    String? nickName,
    RequestDataCallBack<bool>? dataCallBack,
  }) async {
    String url = await EHttpRequest.url("/v1/user/signUp");

    Map parameters = {
      "phone": phone,
      "password": password,
      "password2": password2,
      "name": nickName
    };

    return EHttpRequest.post(url, parameters: parameters, onSuccess: (data) {
      if (dataCallBack != null) {
        var d = data as Map<String, dynamic>?;

        // if (d != null) {
        //   UserBean bean = UserBean.fromJson(d);
        //   dataCallBack(bean, null);
        // } else {
        //   dataCallBack(null, "数据解析失败");
        // }
      }
    }, onError: (error) {
      showToast(error);
      if (dataCallBack != null) {
        dataCallBack(null, error);
      }
    });
  }
}
