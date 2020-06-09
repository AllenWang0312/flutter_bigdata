
import 'package:bigdata/shop/pages/cert_detial.dart';
import 'package:bigdata/shop/pages/home_page.dart';
import 'package:bigdata/shop/pages/webview_page.dart';
import 'package:bigdata/shop/splash.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SplashPage();
    });

var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new HomePage();
    });

var webViewHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      //获取路由跳转传来的参数
      String url = params["url"].first;
      String title = params["title"].first;
      return new WebViewPage(url, title);
    });
var certDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String cert_id = params["cert_id"].first;
      print(cert_id);
      return new CertDetailPage(cert_id);
    });