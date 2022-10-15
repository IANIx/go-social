import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_social/pages/common/manager/user_manager.dart';
import 'package:flutter_social/util/toast_util.dart';

import 'base/request_url.dart';

part 'base/dio_request.dart';
part 'bean/response_bean.dart';

typedef RequestDataCallBack<T> = void Function(T?, String? e);

class Method {
  static const String get = "GET";
  static const String post = "POST";
  static const String put = "PUT";
  static const String head = "HEAD";
  static const String delete = "DELETE";
  static const String patch = "PATCH";
}

class StatusCode {
  // 请求状态码：成功
  static const STATUS_CODE_SUCCESS = 200;

  // 请求状态码：Token 过期
  static const STATUS_CODE_TOKEN_EXPIRED = 401;

  /// 请求状态码：服务器内部异常
  static const STATUS_CODE_INTERNAL_SERVER_ERROR = 500;

  // Token 无效
  static const RESPONSE_CODE_TOKEN_INVALID = -6;

  // 请求处理无误
  static const REQUEST_RESULT_CODE_SUCCESS = 0;

  // 账号在其他设备登录
  static const REQUEST_RESULT_CODE_EXPIRED = 401;
}

class ServerConfig {
  static String get host {
    return ERequestUrl.LOCOAL_URL;
  }
}

class EHttpRequest {
  ///Get请求
  static Future<bool> get<T>(
    String url, {
    parameters,
    headers,
    Function(T? t)? onSuccess,
    Function(String error)? onError,
  }) async {
    return DioRequest.request(url,
        parameters: parameters ?? {},
        headers: headers,
        method: Method.get,
        onSuccess: onSuccess,
        onError: onError);
  }

  /// Post请求
  /// onSuccess 请求处理成功
  /// onHandled 请求处理无误
  static Future<bool> post<T>(
    String url, {
    parameters,
    headers,
    formdata = false,
    Function(T? t)? onSuccess,
    Function(String error)? onError,
  }) async {
    return DioRequest.request(
      url,
      parameters: parameters ?? {},
      headers: headers,
      method: Method.post,
      formdata: formdata,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Post请求
  /// onSuccess 请求处理成功
  /// onHandled 请求处理无误
  static Future<bool> postImage<T>(
    String url, {
    FormData? imageDta,
    Function(T? t)? onSuccess,
    Function(String error)? onError,
  }) async {
    return DioRequest.uploadImage(
      url,
      imageDta: imageDta,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// 加密请求
  /// onSuccess 请求处理成功
  /// onHandled 请求处理无误
  static Future<bool> encryptRequest<T>(
    String url, {
    parameters,
    headers,
    Function(T? t)? onSuccess,
    Function(T t)? onHandled,
    Function(String error)? onError,
  }) async {
    return DioRequest.request(
      url,
      encrypt: true,
      parameters: parameters,
      headers: headers,
      method: Method.post,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// 获取请求地址
  /// path: 地址路径
  ///
  static Future<String> url(String path) async {
    if (path.isEmpty) return '';

    return ServerConfig.host + path;
  }
}
