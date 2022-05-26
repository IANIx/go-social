import 'package:flutter/material.dart';
import 'package:flutter_social/pages/common/widget/network_image_widget.dart';
import 'package:flutter_social/pages/feedDetail/bean/article_detail_bean.dart';
import 'package:flutter_social/pages/feedDetail/request/feed_request.dart';
import 'package:flutter_social/util/toast_util.dart';

class ArticleCommentWidget extends StatefulWidget {
  final ArticleCommentBean commentBean;
  final VoidCallback reloadCallBack;
  ArticleCommentWidget(this.commentBean, this.reloadCallBack, {Key? key})
      : super(key: key);

  @override
  State<ArticleCommentWidget> createState() => _ArticleCommentWidgetState();
}

class _ArticleCommentWidgetState extends State<ArticleCommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      // margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                child: ENetworkImage(
                  imageUrl: widget.commentBean.avatar,
                  radius: 15,
                  placeholder: (context, url) => Container(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.commentBean.nickName,
                    style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "5小时前",
                    style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  _likeComment();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("${widget.commentBean.like_num}",
                        style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                        widget.commentBean.isLike
                            ? Icons.thumb_up_alt
                            : Icons.thumb_up_alt_outlined,
                        color: widget.commentBean.isLike
                            ? Colors.orangeAccent
                            : Color(0xFF666666),
                        size: 20)
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.commentBean.comment_cont,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 15,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 0.5,
            color: Colors.black12,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  _likeComment() {
    FeedRequest.giveLike(
      type: 2,
      typeId: widget.commentBean.commentId,
      dataCallBack: (d, e) {
        if (d == true) {
          showToast("操作成功");
          widget.reloadCallBack();
        }
      },
    );
  }
}
