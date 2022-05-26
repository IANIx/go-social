part of '../http_request.dart';

typedef ListDataCallBack<T> = void Function(List<T>, String e);
typedef DataCallBack<T> = void Function(T data, String e);
typedef SingleCallBack<T> = void Function(T data);

class ResponseBean {
  final int? code;
  final dynamic data;
  final String? msg;
  final String? message;

  ResponseBean(
      {required this.code, this.data, required this.msg, this.message});

  /// 反序列化
  factory ResponseBean.fromJson(Map<String, dynamic> json) =>
      _$ResponseBeanFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$ResponseBeanToJson(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBean _$ResponseBeanFromJson(Map<String, dynamic> json) {
  return ResponseBean(
      code: json['code'] as int?,
      data: json['data'],
      msg: json['msg'] as String?,
      message: json['message'] as String?);
}

Map<String, dynamic> _$ResponseBeanToJson(ResponseBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'message': instance.message,
    };
