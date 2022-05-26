import 'package:flutter_social/network/http_request.dart';
import 'package:flutter_social/pages/common/bean/user_bean.dart';
import 'package:flutter_social/pages/feedDetail/bean/article_detail_bean.dart';
import 'package:flutter_social/util/toast_util.dart';

class FeedRequest {
  /// 发布文章
  static Future<bool> postArticle({
    required String title,
    required String content,
    String? imgUrl,
    RequestDataCallBack<UserBean>? dataCallBack,
  }) async {
    String url = await EHttpRequest.url("/v1/feed/post");

    Map parameters = {
      "title": title,
      "content": content,
      "imgUrl": imgUrl ?? ""
    };

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

  /// 文章详情
  static Future<bool> articleDetail({
    required int id,
    RequestDataCallBack<ArticleDetailBean>? dataCallBack,
  }) async {
    String url = await EHttpRequest.url("/v1/feed/article/detail");

    Map parameters = {"articleId": id};

    return EHttpRequest.post(url, parameters: parameters, onSuccess: (data) {
      if (dataCallBack != null) {
        var d = data as Map<String, dynamic>?;

        if (d != null) {
          ArticleDetailBean bean = ArticleDetailBean.fromJson(d);

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

  /// 发布文章评论
  static Future<bool> articleComment({
    required int id,
    required String content,
    RequestDataCallBack<bool>? dataCallBack,
  }) async {
    String url = await EHttpRequest.url("/v1/feed/article/comment");

    Map parameters = {"articleId": id, "comment": content};

    return EHttpRequest.post(url, parameters: parameters, onSuccess: (data) {
      if (dataCallBack != null) {
        dataCallBack(true, "操作成功");
      }
    }, onError: (error) {
      showToast(error);
      if (dataCallBack != null) {
        dataCallBack(null, error);
      }
    });
  }

  /// 文章/评论点赞
  static Future<bool> giveLike({
    required int type,
    required int typeId,
    RequestDataCallBack<bool>? dataCallBack,
  }) async {
    String url = await EHttpRequest.url("/v1/feed/giveLike");

    Map parameters = {"type": type, "typeId": typeId};

    return EHttpRequest.post(url, parameters: parameters, onSuccess: (data) {
      if (dataCallBack != null) {
        dataCallBack(true, "操作成功");
      }
    }, onError: (error) {
      showToast(error);
      if (dataCallBack != null) {
        dataCallBack(null, error);
      }
    });
  }
}
