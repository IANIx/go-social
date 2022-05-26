import 'package:flutter/material.dart';

import 'request/feed_request.dart';

class PostArticlePage extends StatefulWidget {
  PostArticlePage({Key? key}) : super(key: key);

  @override
  State<PostArticlePage> createState() => _PostArticlePageState();
}

class _PostArticlePageState extends State<PostArticlePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发布文章"),
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [_buildTitle(), _buildContent(), _buidConfirm()],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      height: 50,
      color: Colors.white,
      child: TextField(
        controller: titleController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "请输入标题",
            labelStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      height: 300,
      margin: EdgeInsets.only(top: 16),
      color: Colors.white,
      child: TextField(
        maxLines: 6,
        controller: contentController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "请输入内容",
            labelStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _buidConfirm() {
    return ElevatedButton(
        onPressed: () => _onPost(),
        child: Container(
          height: 50,
          width: double.infinity,
          child: Center(
            child: Text("发布"),
          ),
        ));
  }

  _onPost() {
    FeedRequest.postArticle(
        title: titleController.text, content: contentController.text);
  }
}
