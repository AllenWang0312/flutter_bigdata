import 'dart:convert';

import 'package:bigdata/ykt/service/http_service.dart';

import '../model/menu.dart';
import '../../custom/widgets/custom_appbar.dart';
import '../route/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  var menus = [
    Menu(name: "我的证书", msgCount: 1, info: "4", more: true),
    Menu(name: "历史学习", more: true),
    Menu(name: "积分商城", more: true),
    Menu(name: "我的订单", more: true),
    Menu(name: "推荐给好友", more: true),
    Menu(name: "意见反馈", more: true),
    Menu(name: "帮助中心", more: true),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MyApp.token);

    return Scaffold(
      appBar: CustomAppbar(
        leadingWidget: Icon(Icons.message),
        trailingWidget: InkWell(
          child: Icon(Icons.settings),
          onTap: () {
            MyApp.router.navigateTo(context, Routes.setting);
          },
        ),
      ),
      body: FutureBuilder(
        future: post('getMineInfo', formData: {'user_ticket', MyApp.token}),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var rep = json.decode(snapshot.data.toString());
            var data = rep['data'];
            print(data);
            return Text('请求成功');
//            return Container(
//              child: Column(
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Image.network(
//                        data['userpic'],
//                        width: 80,
//                        height: 80,
//                      ),
//                      Text(data['name'])
//                    ],
//                  ),
//                  Row(
//                    children: <Widget>[
//                      Column(
//                        children: <Widget>[Text(data['credit']), Text('学分')],
//                      ),
//                      Column(
//                        children: <Widget>[
//                          Text(data['credit_rank']),
//                          Text('积分排行榜')
//                        ],
//                      ),
//                      Column(
//                        children: <Widget>[
//                          Text(data['favorite_num']),
//                          Text('收藏')
//                        ],
//                      )
//                    ],
//                  ),
//                ],
//              ),
//            );
          } else {
            return Text('加载中');
          }
        },
      ),
//      inflateMenu(),
//      SingleChildScrollView(
////          physics: BouncingScrollPhysics(),
//          child: Container(
//        child: Column(
//          children: <Widget>[infoCard(), inflateMenu()],
//        ),
//      )),
    );
  }

  Widget nullableText(String data) {
    if (data.isEmpty) {
      return Text(
        data,
        textAlign: TextAlign.right,
      );
    } else {
      return Stack();
    }
  }

  inflateMenu() {
    return SizedBox(
      height: 900,
      child: ListView.builder(
        itemCount: menus.length,
        shrinkWrap: true, //height
        physics: const NeverScrollableScrollPhysics(), //禁止滑动
        itemBuilder: (context, index) {
          return Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
//                        Container(
//                          width: 32,
//                          height: 32,
////                        child: Image.asset(menus[index].icon),
//                        ),
                  Text(menus[index].name),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(4.0)),
//                          borderRadius: BorderRadiusGeometry.lerp(a, b, t)
                    ),
                  ),
                  Expanded(child: nullableText(menus[index].info)),

                  Container(
                    width: 8,
                    height: 16,
                    child: Image.asset("images/right_arrow_gary.png"),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Widget infoCard() {
    return Container(
      height: 200,
      child: Stack(
        children: <Widget>[Image.asset('images/right_arrow_gary.png')],
      ),
    );
  }
}
