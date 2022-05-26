import 'package:flutter/material.dart';
import 'package:flutter_social/pages/common/widget/network_image_widget.dart';
import 'package:flutter_social/pages/feedDetail/article_detail_page.dart';
import 'package:flutter_social/pages/home/bean/article_list_bean.dart';

class ArticleWidget extends StatefulWidget {
  final ArticleBean? bean;

  ArticleWidget(this.bean, {Key? key}) : super(key: key);

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => ArticleDetailPage(widget.bean))),
      child: Container(
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
                  width: 30,
                  height: 30,
                  child: ENetworkImage(
                    imageUrl: widget.bean?.avatar ?? "",
                    radius: 15,
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "${widget.bean?.praiseNum ?? 0}赞同 · ${widget.bean?.commentNum ?? 0}评论",
                  style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
