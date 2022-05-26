import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_social/pages/common/manager/user_manager.dart';

import 'pages/feedDetail/post_article_page.dart';
import 'pages/home/home.dart';
import 'pages/login/login_page.dart';
import 'pages/mine/mine.dart';
import 'util/event_bus_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.orange, primaryColor: Colors.white),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    UserManager.getUserInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EntrancePage();
  }
}

class EntrancePage extends StatefulWidget {
  EntrancePage({Key? key}) : super(key: key);

  @override
  State<EntrancePage> createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  late StreamSubscription _subscription;
  List<Widget> pages = [HomePage(), MinePage()];
  var _index = 0;

  @override
  void initState() {
    _subscription = eventBus.on().listen((event) {
      if (event is LoginEvent) {
        _pushToLogin();
      } else if (event is BackHomeEvent) {
        setState(() {
          _index = 0;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _index = 0;
                });
              },
              child: Container(
                height: 50,
                width: 100,
                color: Colors.transparent,
                child: Icon(Icons.home),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (UserManager.isLogin != true) {
                  eventBus.fire(LoginEvent());
                } else {
                  setState(() {
                    _index = 1;
                  });
                }
              },
              child: Container(
                height: 50,
                width: 100,
                color: Colors.transparent,
                child: Icon(Icons.people),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (UserManager.isLogin != true) {
            eventBus.fire(LoginEvent());
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PostArticlePage()));
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _pushToLogin() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }
}
