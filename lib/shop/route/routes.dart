
import 'package:bigdata/shop/route/route_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routes{
  static String root = "/";
  static String login ="/login";
  static String index ="/index";
  static String web ="/web";
  static String certDetail ="/cert/detail";
  static String setting='/user/setting';
  static String userinfo='/user/info';

  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      // ignore: missing_return
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('route is not find!');
      }
    );
    router.define(root, handler: splashHandler);
    router.define(index, handler: indexHandler);
    router.define(login, handler: loginHandler);

    router.define(web, handler: webViewHandler);
    router.define(certDetail, handler: certDetailHandler);

    router.define(setting, handler: userInfoHandler);
    router.define(userinfo, handler: userInfoHandler);
  }
}