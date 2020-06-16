import 'dart:convert';

import 'package:bigdata/shop/config/color.dart';
import 'package:bigdata/shop/main.dart';
import 'package:bigdata/shop/pages/widgets/custom_appbar.dart';
import 'package:bigdata/shop/route/routes.dart';
import 'package:bigdata/shop/service/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final account_controller = TextEditingController();
  final psw_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Image.asset('images/login_bg.png'),
            Positioned(
              right: 0,
              child: Container(
                  margin: EdgeInsets.only(right: 8, top: 24),
                  child: InkWell(
                    child: Text(
                      '随便看看 >',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    onTap: () {
                      MyApp.router.navigateTo(context, '/index');
                    },
                  )),
            ),
            Container(
              margin: EdgeInsets.only(left: 18, top: 86, right: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '登录',
                    style: TextStyle(fontSize: 32, fontStyle: FontStyle.normal),
                  ),
//                  Text(
//                    '手机号/邮箱/账户',
//                    style: TextStyle(fontSize: 16),
//                  ),
                  TextField(
                    controller: account_controller,
                    decoration: InputDecoration(
//                        fillColor: Colors.blue.shade100,
//                        filled: true,
                        labelText: '手机号/邮箱/账户'),
                    maxLength: 30,
                    maxLines: 1,
                    autofocus: true,
                    style: TextStyle(fontSize: 16, color: KColor.editTextColor),
//                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
//                    onChanged: (text){},
//                    onSubmitted: (text){},
//                    enabled: true,
                  ),
//                  Text(
//                    '密码',
//                    style: TextStyle(fontSize: 16),
//                  ),
                  TextField(
                    controller: psw_controller,
                    decoration: InputDecoration(
//                        fillColor: Colors.blue.shade100,
//                        filled: true,
                        labelText: '密码'),
                    maxLength: 30,
                    maxLines: 1,
                    autofocus: true,
                    style: TextStyle(fontSize: 16, color: KColor.editTextColor),
                  ),
                  InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 18),
                        height: 48,
                        decoration: new BoxDecoration(
                          color: Colors.blue,
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(24.0)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '登录',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      onTap: () {
                        var account = account_controller.text;
                        var psw = psw_controller.text;
                        if (account.isNotEmpty && psw.isNotEmpty) {
                          login(context, account, psw);
                        } else {
                          Fluttertoast.showToast(msg: "请正确填写用户名与密码");
                        }
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Function callback(BuildContext context, dynamic snapshot) {
    var value = json.decode(snapshot.toString());
    var errCode = value['errCode'];
    var msg = value['msg'];
    var data = value['data'];
    onLoginSuccess(data);
  }

  void login(BuildContext context, String account, String psw) {
    post("accountLogin", formData: {
      'username': account,
      'password': psw,
      'type': 1,
      'device': 'jpush_id',
      'device_type': '4'
    }).then((value) {
      callback(context, value);
    });
  }

  void onLoginSuccess(dynamic data) {
    if (null == data['name']) {
    } else if (null == data['class_id'] || 0 == data['class_id']) {
    } else {
      MyApp.token = data['user_ticket'];
      var path = Routes.index +
          '?class_id=' +
          data['class_id'] +
          "&count=${data['ihma_count']}&class_name=" +
          Uri.encodeComponent(data['class_name']);
      print(path);
      MyApp.router.navigateTo(context, path);
    }
  }
}
