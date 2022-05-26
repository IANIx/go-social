import 'package:flutter_social/network/http_request.dart';
import 'package:flutter_social/pages/home/bean/article_list_bean.dart';
import 'package:flutter_social/util/toast_util.dart';

class HomeRequest {
  /// 查询文章列表
  static Future<bool> articleList({
    required String path,
    required int pageNum,
    RequestDataCallBack<ArticleListBean>? dataCallBack,
  }) async {
    String url = await EHttpRequest.url(path);

    return EHttpRequest.post(url,
        parameters: {"pageNum": pageNum, "pageSize": 10}, onSuccess: (data) {
      if (dataCallBack != null) {
        var d = data as Map<String, dynamic>?;

        if (d != null) {
          ArticleListBean bean = ArticleListBean.fromJson(d);

          print("呵呵哒 总页数${bean.pages}");
          print("呵呵哒 当前页数${bean.current_page}");
          print("呵呵哒 总条数数${bean.total}");
          print("呵呵哒 拿到数据${bean.list?.length}");

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
}
