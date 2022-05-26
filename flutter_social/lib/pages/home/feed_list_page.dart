import 'package:flutter/material.dart';
import 'package:flutter_social/pages/common/widget/provider_widget.dart';
import 'package:flutter_social/pages/home/provider/home_notice.dart';
import 'package:flutter_social/pages/home/widget/article_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeedListPage extends StatefulWidget {
  final String title;
  final String path;
  FeedListPage(this.title, this.path, {Key? key}) : super(key: key);

  @override
  State<FeedListPage> createState() => _FeedListPageState();
}

class _FeedListPageState extends State<FeedListPage> {
  late HomeNotice _homeNotice;

  @override
  void initState() {
    _homeNotice = HomeNotice(widget.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return EProviderWidget(
        builder: (context, model, child) {
          return Container(child: _buildList());
        },
        onModelReady: (model) => _homeNotice.initData(),
        model: _homeNotice);
  }

  _buildList() {
    return Container(child: _smartRefresher());
  }

  SmartRefresher _smartRefresher() {
    return SmartRefresher(
      controller: _homeNotice.refreshController,
      onRefresh: _homeNotice.initData,
      onLoading: _homeNotice.nextData,
      enablePullUp: true,
      enablePullDown: true,
      child: ListView.builder(
        itemBuilder: (c, i) {
          return ArticleWidget(_homeNotice.dataList[i]);
        },
        itemCount: _homeNotice.dataList.length,
      ),
    );
  }
}
