import 'package:flutter/material.dart';
import 'package:flutter_social/constant/string_constant.dart';
import 'package:flutter_social/pages/common/manager/user_manager.dart';
import 'package:flutter_social/pages/login/request/login_request.dart';
import 'package:flutter_social/util/cache_util.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nickController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController pwd2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
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
              controller: nickController,
              decoration: InputDecoration(
                  labelText: '昵称：', labelStyle: TextStyle(color: Colors.red)),
            ),
            SizedBox(
              height: 30,
            ),
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
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: pwd2Controller,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: '确认密码：', labelStyle: TextStyle(color: Colors.red)),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(child: Container()),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () => _onRegister(),
                child: Container(
                  height: 50,
                  width: 300,
                  child: Center(
                    child: Text("注册"),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _onRegister() {
    print("register");
    var nick = nickController.text;
    var phone = phoneController.text;
    var password = pwdController.text;
    var password2 = pwd2Controller.text;

    LoginRequest.register(
        phone: phone,
        password: password,
        password2: password2,
        nickName: nick,
        dataCallBack: (bean, err) {
          if (bean != null) {
            UserManager.isLogin = false;
            ESpHelper.set(EStrings.USER_PERSON, "");
          }
        });
  }
}
