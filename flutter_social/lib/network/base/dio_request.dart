part of '../http_request.dart';

class DioRequest {
  static Dio? dio;
  static BaseOptions _baseOptions = BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
    responseType: ResponseType.plain,
    contentType: 'application/json; charset=utf-8',
    validateStatus: (status) {
      // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
      return true;
    },
  );

  // request method
  // url 请求链接
  // parameters 请求参数
  // method 请求方式
  // onHandled 获取 data 回调
  // onSuccess 成功回调
  // onError 失败回调
  static Future<bool> request<T>(String url,
      {parameters,
      headers,
      String method = Method.get,
      bool formdata = false,
      bool encrypt = false,
      Function(T? t)? onSuccess,
      Function(String error)? onError}) async {
    /// parameters配置
    parameters =
        parameters != null ? Map<String, dynamic>.from(parameters) : {};

    /// header配置
    Map<String, dynamic> header = await _configUserHeaders();
    if (headers != null) {
      header.addAll(headers);
    }

    Dio dio = Dio(_baseOptions);

    // 请求结果
    var result;
    try {
      Response response;
      if (method == Method.get) {
        response = await dio.get(url,
            queryParameters: parameters,
            options: new Options(method: method, headers: header));
      } else {
        response = await dio.request(url,
            data: formdata ? FormData.fromMap(parameters) : parameters,
            options: new Options(method: method, headers: header));
      }

      print(
        'method - $method \n '
        'url - $url \n '
        'headers - $header \n '
        'parameters - $parameters \n '
        'response - ${response.toString()} \n '
        'statusCode - ${response.statusCode}\n',
      );

      if (response.statusCode == StatusCode.STATUS_CODE_SUCCESS) {
        if (result == null) {
          result = jsonDecode(response.data);
        }

        ResponseBean resultData =
            ResponseBean.fromJson(result as Map<String, dynamic>);
        if (resultData.code == StatusCode.REQUEST_RESULT_CODE_SUCCESS) {
          if (onSuccess != null) {
            onSuccess(resultData.data);
          }
        } else if (resultData.code == StatusCode.REQUEST_RESULT_CODE_EXPIRED) {
          String msg = (resultData.msg ?? resultData.message) ?? '账号异常';
          UserManager.clearUserInfo();
          showToast(msg);
          if (onError != null) {
            onError(msg);
          }
        } else {
          if (onError != null) {
            onError((resultData.message ?? resultData.msg) ?? "数据异常");
          }
        }
      } else if (response.statusCode == StatusCode.STATUS_CODE_TOKEN_EXPIRED) {
        UserManager.clearUserInfo();
      } else {
        throw Exception('statusCode:${response.statusCode}');
      }
      return true;
    } on FormatException catch (e) {
      print('数据解析失败：' + e.toString() + "---url: $url");
      if (onError != null) {
        onError('数据解析失败');
      }
      return false;
    } on Exception catch (e) {
      print('请求出错：' + e.toString() + "---url: $url");
      if (onError != null) {
        onError('网络不好，请查看网络');
      }
      return false;
    }
  }

  static Future<bool> uploadImage<T>(String url,
      {FormData? imageDta,
      Function(T? t)? onSuccess,
      Function(T t)? onHandled,
      Function(String error)? onError}) async {
    /// header配置
    Map<String, dynamic> header = await _configUserHeaders();

    Dio dio = Dio(_baseOptions);

    // 请求结果
    var result;
    try {
      Response response = await dio.post<String>(url, data: imageDta);

      print(
        'url - $url \n '
        'headers - $header \n '
        'response - ${response.toString()} \n '
        'statusCode - ${response.statusCode}\n',
      );

      if (response.statusCode == StatusCode.STATUS_CODE_SUCCESS) {
        if (onSuccess != null) {
          result = jsonDecode(response.toString());
          onSuccess(result);
        }
      } else {
        throw Exception('statusCode:${response.statusCode}');
      }
      return true;
    } on FormatException catch (e) {
      print('数据解析失败：' + e.toString() + "---url: $url");
      if (onError != null) {
        onError('数据解析失败');
      }
      return false;
    } on Exception catch (e) {
      print('请求出错：' + e.toString() + "---url: $url");
      if (onError != null) {
        onError('网络不好，请查看网络');
      }
      return false;
    }
  }

  /// 获取 dio 实例
  static Future<Dio?> getInstance(String url) async {
    if (dio == null) {
      initDio();
    }
    return dio;
  }

  /// 初始化 dio
  static void initDio() {
    /// 全局属性：请求前缀、连接超时时间、响应超时时间
    var options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      responseType: ResponseType.plain,
      contentType: 'application/json; charset=utf-8',
      validateStatus: (status) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
    );

    dio = new Dio(options);
  }

  /// 配置用户信息请求头
  static Future<Map<String, dynamic>> _configUserHeaders() async {
    String? token = await UserManager.getUserToken();
    if (token != null && token.isNotEmpty) {
      String auth = "Bearer $token";
      return {"Authorization": auth};
    }

    Map<String, dynamic> map = {
      // "Authorization":
      //     "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
    };

    return map;
  }

  /// 清空 dio 对象
  static _clear() {
    dio = null;
  }

  static _handleSucceed(result) {
    return result is Map &&
        result['code'] == StatusCode.REQUEST_RESULT_CODE_SUCCESS;
  }
}
