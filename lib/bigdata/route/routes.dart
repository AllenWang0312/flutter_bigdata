
import 'route_handlers.dart';
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
    router.define(index, handler: indexHandler);
  }
}