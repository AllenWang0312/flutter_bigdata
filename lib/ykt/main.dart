import 'package:shared_preferences/shared_preferences.dart';

import 'route/routes.dart';
import 'splash.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'pages/index_page.dart';
import '../custom/provide/current_index_provide.dart';
import 'config/index.dart';

void main() {
  var currentIndexProvide = BNBIndexObservable(0);
  var providers = Providers();
  providers..provide(Provider<BNBIndexObservable>.value(currentIndexProvide));



  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  static String token = "";
  static final router = Router();

  MyApp() {
    Routes.configureRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: KString.mainTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: KColor.primaryColor,
        platform: TargetPlatform.iOS,
      ),
      home: SplashPage(),
      onGenerateRoute: router.generator,
    );
  }
}
