import 'package:json_annotation/json_annotation.dart';
part 'article_detail_bean.g.dart';

@JsonSerializable()
class ArticleDetailBean {
  bool isLike;
  List<ArticleLikeBean> likeList;
  List<ArticleCommentBean>? commentList;

  ArticleDetailBean(this.isLike, this.likeList, this.commentList);

  /// 反序列化
  factory ArticleDetailBean.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailBeanFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$ArticleDetailBeanToJson(this);
}

@JsonSerializable()
class ArticleLikeBean {
  int type;
  int typeId;
  int userId;
  String nickName;
  String avatar;
  double createTime;

  ArticleLikeBean(this.type, this.typeId, this.userId, this.nickName,
      this.avatar, this.createTime);

  /// 反序列化
  factory ArticleLikeBean.fromJson(Map<String, dynamic> json) =>
      _$ArticleLikeBeanFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$ArticleLikeBeanToJson(this);
}

@JsonSerializable()
class ArticleCommentBean {
  int commentId;
  int articleId;
  int userId;
  String comment_cont;
  String nickName;
  String avatar;
  int createTime;
  int like_num;
  bool isLike;

  ArticleCommentBean(
      this.commentId,
      this.articleId,
      this.userId,
      this.comment_cont,
      this.nickName,
      this.avatar,
      this.createTime,
      this.like_num,
      this.isLike);

  /// 反序列化
  factory ArticleCommentBean.fromJson(Map<String, dynamic> json) =>
      _$ArticleCommentBeanFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$ArticleCommentBeanToJson(this);
}
