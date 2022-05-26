import 'package:flutter/material.dart';
import 'package:flutter_social/pages/common/widget/network_image_widget.dart';
import 'package:flutter_social/pages/home/bean/article_list_bean.dart';
import 'package:flutter_social/util/toast_util.dart';

import 'bean/article_detail_bean.dart';
import 'request/feed_request.dart';
import 'widgets/article_comment_widget.dart';
import 'widgets/article_like_widget.dart';

class ArticleDetailPage extends StatefulWidget {
  final ArticleBean? bean;
  ArticleDetailPage(this.bean, {Key? key}) : super(key: key);

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  ArticleDetailBean? detailBean;
  int _selectIndex = 0; // 0：评论 1：点赞

  @override
  void initState() {
    _getDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildActions(),
          _buildTools(),
          _buildDetailContent()
        ],
      ),
    ));
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.bean?.title ?? "",
            style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                child: ENetworkImage(
                  imageUrl: widget.bean?.avatar ?? "",
                  radius: 20,
                  placeholder: (context, url) => Container(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.bean?.nickName ?? "",
                style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.bean?.content ?? "",
            style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 17,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Container(
      height: 50,
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    showComment(context);
                  },
                  child: Icon(Icons.comment))),
          Container(
            width: 0.5,
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.black45,
          ),
          Expanded(
              child: GestureDetector(
            onTap: () {
              _likeArticle();
            },
            child: _buildLikeButton(),
          ))
        ],
      ),
    );
  }

  _buildTools() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _selectIndex = 0;
              });
            },
            child: Text(
              "评论",
              style: TextStyle(
                  color: _selectIndex == 0 ? Colors.black : Color(0xFF666666),
                  fontWeight:
                      _selectIndex == 0 ? FontWeight.bold : FontWeight.normal),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectIndex = 1;
              });
            },
            child: Text(
              "点赞",
              style: TextStyle(
                  color: _selectIndex == 1 ? Colors.black : Color(0xFF666666),
                  fontWeight:
                      _selectIndex == 1 ? FontWeight.bold : FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }

  _buildDetailContent() {
    if (_selectIndex == 0) {
      return _buildComments();
    } else {
      return _buildLikes();
    }
  }

  _buildComments() {
    List<Widget> widgets = [];
    List<ArticleCommentBean> list = detailBean?.commentList ?? [];
    for (int i = 0; i < list.length; i++) {
      widgets.add(ArticleCommentWidget(list[i], () {
        _getDetail();
      }));
    }

    return Column(
      children: widgets,
    );
  }

  _buildLikes() {
    List<Widget> widgets = [];
    List<ArticleLikeBean> list = detailBean?.likeList ?? [];
    for (int i = 0; i < list.length; i++) {
      widgets.add(ArticleLikeWidget(list[i]));
    }

    return Column(
      children: widgets,
    );
  }

  Widget _buildLikeButton() {
    bool isLike = detailBean?.isLike ?? false;

    return Icon(
      isLike ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
      color: isLike ? Colors.orangeAccent : Colors.black,
    );
  }

  showComment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: 414,
          height: 100,
          margin: EdgeInsets.only(bottom: 300),
          child: TextField(
            autofocus: true,
            onSubmitted: (value) {
              _postComment(value);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  _getDetail() {
    FeedRequest.articleDetail(
      id: widget.bean?.articleId ?? 0,
      dataCallBack: (bean, e) {
        if (bean != null) {
          setState(() {
            detailBean = bean;
          });
        }
      },
    );
  }

  _postComment(String text) {
    FeedRequest.articleComment(
      id: widget.bean?.articleId ?? 0,
      content: text,
      dataCallBack: (d, e) {
        if (d == true) {
          _getDetail();
        }
      },
    );
  }

  _likeArticle() {
    FeedRequest.giveLike(
      type: 1,
      typeId: widget.bean?.articleId ?? 0,
      dataCallBack: (d, e) {
        if (d == true) {
          _getDetail();
        }
      },
    );
  }
}
