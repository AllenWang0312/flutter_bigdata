
import 'package:bigdata/shop/pages/cert_detial.dart';
import 'package:bigdata/shop/pages/home_page.dart';
import 'package:bigdata/shop/pages/index_page.dart';
import 'package:bigdata/shop/pages/login_page.dart';
import 'package:bigdata/shop/pages/setting_page.dart';
import 'package:bigdata/shop/pages/user_info_page.dart';
import 'package:bigdata/shop/pages/webview_page.dart';
import 'package:bigdata/shop/pages/widgets/custom_appbar.dart';
import 'package:bigdata/shop/splash.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SplashPage();
    });

var indexHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new IndexPage();
    });

var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new LoginPage();
    });


var webViewHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      //获取路由跳转传来的参数
      String url = params["url"].first;
      String title = params["title"].first;
      print(url+title);
//      return new WebViewPage(url, title);
      return WebViewPage(title, url);
    });
var certDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String cert_id = params["cert_id"].first;
      print(cert_id);
      return new CertDetailPage(cert_id);
    });

var settingHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SettingPage();
    });
var userInfoHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new UserInfoPage();
    });