// ignore: import_of_legacy_library_into_null_safe
import 'package:json_annotation/json_annotation.dart';
part 'article_list_bean.g.dart';

@JsonSerializable()
class ArticleListBean {
  int total;
  int pages;
  int current_page;
  List<ArticleBean>? list;

  ArticleListBean(this.total, this.pages, this.current_page, this.list);

  /// 反序列化
  factory ArticleListBean.fromJson(Map<String, dynamic> json) =>
      _$ArticleListBeanFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$ArticleListBeanToJson(this);
}

@JsonSerializable()
class ArticleBean {
  int? articleId;
  String? title;
  String? content;
  String? img;
  int? commentNum;
  int? praiseNum;
  int? userId;
  String? nickName;
  String? avatar;
  int? createTime;

  ArticleBean(
      this.articleId,
      this.title,
      this.content,
      this.img,
      this.commentNum,
      this.praiseNum,
      this.userId,
      this.nickName,
      this.avatar,
      this.createTime);

  /// 反序列化
  factory ArticleBean.fromJson(Map<String, dynamic> json) =>
      _$ArticleBeanFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$ArticleBeanToJson(this);
}
