
import 'package:bigdata/shop/route/route_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routes{
  static String root = "/";

  static String home ="/home";
  static String web ="/web";
  static String certDetail ="/cert/detail";

  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      // ignore: missing_return
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('route is not find!');
      }
    );
    router.define(root, handler: splashHandler);
    router.define(home, handler: homeHandler);
    router.define(web, handler: webViewHandler);
    router.define(certDetail, handler: certDetailHandler);
  }
}