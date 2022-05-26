// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleListBean _$ArticleListBeanFromJson(Map<String, dynamic> json) {
  return ArticleListBean(
    json['total'] as int,
    json['pages'] as int,
    json['current_page'] as int,
    (json['list'] as List<dynamic>?)
        ?.map((e) => ArticleBean.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ArticleListBeanToJson(ArticleListBean instance) =>
    <String, dynamic>{
      'total': instance.total,
      'pages': instance.pages,
      'current_page': instance.current_page,
      'list': instance.list,
    };

ArticleBean _$ArticleBeanFromJson(Map<String, dynamic> json) {
  return ArticleBean(
    json['articleId'] as int?,
    json['title'] as String?,
    json['content'] as String?,
    json['img'] as String?,
    json['commentNum'] as int?,
    json['praiseNum'] as int?,
    json['userId'] as int?,
    json['nickName'] as String?,
    json['avatar'] as String?,
    json['createTime'] as int?,
  );
}

Map<String, dynamic> _$ArticleBeanToJson(ArticleBean instance) =>
    <String, dynamic>{
      'articleId': instance.articleId,
      'title': instance.title,
      'content': instance.content,
      'img': instance.img,
      'commentNum': instance.commentNum,
      'praiseNum': instance.praiseNum,
      'userId': instance.userId,
      'nickName': instance.nickName,
      'avatar': instance.avatar,
      'createTime': instance.createTime,
    };
