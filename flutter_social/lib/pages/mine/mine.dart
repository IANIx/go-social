import 'package:flutter/material.dart';
import 'package:flutter_social/pages/common/bean/user_bean.dart';
import 'package:flutter_social/pages/common/manager/user_manager.dart';
import 'package:flutter_social/pages/common/widget/network_image_widget.dart';
import 'package:flutter_social/pages/home/feed_list_page.dart';
import 'package:flutter_social/util/event_bus_util.dart';

import 'bean/user_profile_bean.dart';
import 'request/mine_request.dart';

class MinePage extends StatefulWidget {
  MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  UserBean? userBean;
  UserProfileBean? userProfileBean;

  @override
  void initState() {
    _updateUserInfo();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MinePage oldWidget) {
    _updateUserInfo();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我"),
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
              child: Container(
            child: _buildList(),
          )),
        ],
      ),
    );
  }

  _buildHeader() {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(color: Colors.black12),
            top: BorderSide(color: Colors.black12)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(35)),
                  child: ENetworkImage(
                    imageUrl: userProfileBean?.avatar ?? "",
                    radius: 35,
                    placeholder: (context, url) => Container(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProfileBean?.nickName ?? "",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userBean?.phone ?? "",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 90),
              child: Row(
                children: [
                  Text(
                    "共发布${userProfileBean?.articleNum ?? 0}篇    点赞 ${userProfileBean?.LikesNum ?? 0}    被点赞 ${userProfileBean?.LikedNum ?? 0}",
                    style: TextStyle(fontSize: 15, color: Color(0xFF666666)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildList() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    FeedListPage("我发布的", "/v1/feed/mine"))),
            child: Container(
              height: 50,
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: Text("我发布的文章"),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    FeedListPage("我点赞的", "/v1/feed/mineLike"))),
            child: Container(
              height: 50,
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: Text("我点赞的文章"),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () => _logout(),
            child: Container(
              height: 50,
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: Text("退出登录"),
            ),
          ),
        ],
      ),
    );
  }

  _updateUserInfo() async {
    userBean = await UserManager.getUserInfo();
    setState(() {});

    _getJwt();
  }

  _getJwt() {
    MineRequest.jwt();
    MineRequest.profile(
      dataCallBack: (data, e) {
        if (data != null) {
          setState(() {
            userProfileBean = data;
          });
        }
      },
    );
  }

  _logout() {
    MineRequest.logout(
      dataCallBack: (result, e) {
        if (result == true) {
          UserManager.clearUserInfo();
          eventBus.fire(BackHomeEvent());
        }
      },
    );
  }
}
