import 'package:flutter/material.dart';
import 'package:flutter_social/pages/common/widget/network_image_widget.dart';
import 'package:flutter_social/pages/feedDetail/bean/article_detail_bean.dart';

class ArticleLikeWidget extends StatefulWidget {
  final ArticleLikeBean likeBean;
  ArticleLikeWidget(this.likeBean, {Key? key}) : super(key: key);

  @override
  State<ArticleLikeWidget> createState() => _ArticleLikeWidgetState();
}

class _ArticleLikeWidgetState extends State<ArticleLikeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                child: ENetworkImage(
                  imageUrl: widget.likeBean.avatar,
                  radius: 20,
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
                    widget.likeBean.nickName,
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
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 0.5,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
