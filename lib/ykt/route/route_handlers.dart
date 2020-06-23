import '../pages/cert_detial.dart';
import '../pages/home_page.dart';
import '../pages/index_page.dart';
import '../pages/login_page.dart';
import '../pages/setting_page.dart';
import '../pages/user_info_page.dart';
import '../pages/webview_page.dart';
import '../splash.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashPage();
});

var indexHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return IndexPage();
});

var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

var webViewHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  //获取路由跳转传来的参数
  String url = params["url"].first;
  String title = params["title"].first;
  print(url + title);
//      return new WebViewPage(url, title);
  return WebViewPage(title, url);
});
var certDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String cert_id = params["cert_id"].first;
  print(cert_id);
  return CertDetailPage(cert_id);
});

var settingHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      dynamic info = params["info"].first;
  return SettingPage(info);
});
var userInfoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserInfoPage();
});
