// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDetailBean _$ArticleDetailBeanFromJson(Map<String, dynamic> json) {
  return ArticleDetailBean(
    json['isLike'] as bool,
    (json['likeList'] as List<dynamic>)
        .map((e) => ArticleLikeBean.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['commentList'] as List<dynamic>?)
        ?.map((e) => ArticleCommentBean.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ArticleDetailBeanToJson(ArticleDetailBean instance) =>
    <String, dynamic>{
      'isLike': instance.isLike,
      'likeList': instance.likeList,
      'commentList': instance.commentList,
    };

ArticleLikeBean _$ArticleLikeBeanFromJson(Map<String, dynamic> json) {
  return ArticleLikeBean(
    json['type'] as int,
    json['typeId'] as int,
    json['userId'] as int,
    json['nickName'] as String,
    json['avatar'] as String,
    (json['createTime'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ArticleLikeBeanToJson(ArticleLikeBean instance) =>
    <String, dynamic>{
      'type': instance.type,
      'typeId': instance.typeId,
      'userId': instance.userId,
      'nickName': instance.nickName,
      'avatar': instance.avatar,
      'createTime': instance.createTime,
    };

ArticleCommentBean _$ArticleCommentBeanFromJson(Map<String, dynamic> json) {
  return ArticleCommentBean(
    json['commentId'] as int,
    json['articleId'] as int,
    json['userId'] as int,
    json['comment_cont'] as String,
    json['nickName'] as String,
    json['avatar'] as String,
    json['createTime'] as int,
    json['like_num'] as int,
    json['isLike'] as bool,
  );
}

Map<String, dynamic> _$ArticleCommentBeanToJson(ArticleCommentBean instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'articleId': instance.articleId,
      'userId': instance.userId,
      'comment_cont': instance.comment_cont,
      'nickName': instance.nickName,
      'avatar': instance.avatar,
      'createTime': instance.createTime,
      'like_num': instance.like_num,
      'isLike': instance.isLike,
    };
