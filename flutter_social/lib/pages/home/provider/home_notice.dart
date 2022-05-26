import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_social/pages/feedDetail/request/feed_request.dart';
import 'package:flutter_social/pages/home/bean/article_list_bean.dart';
import 'package:flutter_social/pages/home/request/home_request.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeNotice extends ChangeNotifier {
  RefreshController refreshController = RefreshController();
  List<ArticleBean> _dataList = [];
  int _currentPageIndex = 1;
  int _index = 1;

  final String path;
  HomeNotice(this.path);

  initData() {
    _currentPageIndex = 1;
    fetchFeedData();
    // post();
    // comment();
  }

  nextData() {
    _currentPageIndex++;
    fetchFeedData();
  }

  comment() async {
    var rng = new Random();
//打印变量 rng，随机数范围(0-99);
    int index = rng.nextInt(2042);
    await FeedRequest.articleComment(
        id: index, content: "随机评论 -----》 随机id$index 评论次数$_index");
    _index++;
    if (_index > 3000) {
      return;
    }

    comment();
  }

  post() async {
    await FeedRequest.postArticle(title: "模块化设计_$_index", content: """
本章节我们先讲一讲在软件设计中，模块化的一些设计和复用原则，然后再介绍GoFrame框架的模块化设计，以便于大家更好地了解GoFrame框架模块化设计的思想。

一、什么是模块
模块也称作组件，是软件系统中可复用的功能逻辑封装单位。在不同的软件架构层次，模块的概念会有些不太一样。在开发框架层面，模块是某一类功能逻辑的最小封装单位。在Golang代码层面中，我们也可以将package称作模块。

二、模块化的目标
软件进行模块化设计的目的，是为了使得软件功能逻辑尽可能的解耦和复用，终极目标也是为了保证软件开发维护的效率和质量。

三、模块复用原则
REP 复用/发布等同原则
复用/发布等同原则（Release/Reuse Equivalency Principle）：软件复用的最小粒度应等同于其发布的最小粒度。

直白地说，就是要复用一段代码就把它抽成模块。

CCP 共同闭包原则
共同闭包原则（Common Closure Principle）：为了相同目的而同时修改的类，应该放在同一个模块中。

对大部分应用程序而言，可维护性的重要性远远大于可复用性，由同一个原因引起的代码修改，最好在同一个模块中，如果分散在多个模块中，那么开发、提交、部署的成本都会上升。

CRP 共同复用原则
共同复用原则（Common Reuse Principle）：不要强迫一个模块依赖它不需要的东西。

相信你一定有这种经历，集成了模块A，但模块A依赖了模块B、C。即使模块B、C 你完全用不到，也不得不集成进来。这是因为你只用到了模块A的部分能力，模块A中额外的能力带来了额外的依赖。如果遵循共同复用原则，你需要把A拆分，只保留你要用的部分。

复用原则竞争关系
REP、CCP、CRP 三个原则之间存在彼此竞争的关系。REP 和 CCP 是黏合性原则，它们会让模块变得更大，而 CRP 原则是排除性原则，它会让模块变小。遵守REP、CCP 而忽略 CRP ，就会依赖了太多没有用到的模块和类，而这些模块或类的变动会导致你自己的模块进行太多不必要的发布；遵守 REP 、CRP 而忽略 CCP，因为模块拆分的太细了，一个需求变更可能要改n个模块，带来的成本也是巨大的。
""");
    _index++;
    if (_index > 3000) {
      return;
    }

    post();
  }

  fetchFeedData() async {
    await HomeRequest.articleList(
      path: path,
      pageNum: _currentPageIndex,
      dataCallBack: (data, error) {
        if (refreshController.isRefresh) {
          refreshController.refreshCompleted();
        }

        if (refreshController.isLoading) {
          refreshController.loadComplete();
        }

        if (data != null) {
          if (data.current_page == 1) {
            _dataList.clear();
          }

          if (data.current_page == _currentPageIndex) {
            _dataList.addAll(data.list ?? []);
          }

          if (_dataList.length >= data.total) {
            refreshController.loadNoData();
          } else {
            refreshController.resetNoData();
          }
        }
      },
    );

    notifyListeners();
    // fetchFeedData();
  }

  List<ArticleBean> get dataList => _dataList;
}
