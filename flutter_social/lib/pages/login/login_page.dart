import 'package:flutter/material.dart';
import 'package:flutter_social/constant/string_constant.dart';
import 'package:flutter_social/pages/common/manager/user_manager.dart';
import 'package:flutter_social/pages/login/register_page.dart';
import 'package:flutter_social/pages/login/request/login_request.dart';
import 'package:flutter_social/util/cache_util.dart';
import 'dart:convert' as convert;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 250),
      child: Center(
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  labelText: '手机号：', labelStyle: TextStyle(color: Colors.red)),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: pwdController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: '密码：', labelStyle: TextStyle(color: Colors.red)),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 40,
                )),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => RegisterPage())),
                  child: Text("注册"),
                ),
              ],
            ),
            Expanded(child: Container()),
            ElevatedButton(
                onPressed: () => _onLogin(),
                child: Container(
                  height: 50,
                  width: 300,
                  child: Center(
                    child: Text("登录"),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _onLogin() {
    print("login");
    var phone = phoneController.text;
    var password = pwdController.text;
    LoginRequest.login(
        phone: phone,
        password: password,
        dataCallBack: (bean, err) {
          if (bean != null) {
            UserManager.isLogin = true;
            ESpHelper.set(
                EStrings.USER_PERSON, convert.jsonEncode(bean.toJson()));
          }
        });
  }
}
