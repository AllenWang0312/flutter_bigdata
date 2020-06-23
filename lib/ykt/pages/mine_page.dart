import 'dart:convert';

import 'package:bigdata/ykt/config/http_conf.dart';
import 'package:bigdata/ykt/service/http_service.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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

  dynamic info;

  @override
  Widget build(BuildContext context) {
    print(MyApp.token);

    return Scaffold(
      appBar: CustomAppbar(
        leadingWidget: Icon(Icons.message),
        trailingWidget: InkWell(
          child: Icon(Icons.settings),
          onTap: () {
            MyApp.router.navigateTo(context, Routes.setting + '?info=' + info);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder(
            future: post('getMineInfo', formData: {'user_ticket': MyApp.token}),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.toString());
                var rep = json.decode(snapshot.data.toString());
                if (hasError(rep, context)) {
                  return createHeader(null);
                } else {
                  info = rep['data'];
//                        return Text('请求成功');
                  return createHeader(info);
                }
              } else {
                return createHeader(null);
              }
            },
          ),
          Container(
            height: 8,
            color: Colors.black12,
          ),
          inflateMenu()
        ],
      ),
    );
//      EasyRefresh()
  }

  Widget nullableText(String data) {
    if (null != data && data.isNotEmpty) {
      return Text(
        data,
        textAlign: TextAlign.right,
      );
    } else {
      return Stack();
    }
  }

  Widget infoCard() {
    return Container(
      height: 200,
      child: Stack(
        children: <Widget>[Image.asset('images/right_arrow_gary.png')],
      ),
    );
  }

  Widget inflateMenu() {
    return ListView.builder(
      itemCount: menus.length,
      shrinkWrap: true, //height
      physics: const NeverScrollableScrollPhysics(), //禁止滑动
      itemBuilder: (context, index) {
        return Container(
          height: 36,
          padding: EdgeInsets.only(left: 12, right: 6),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
//                        Container(
//                          width: 32,
//                          height: 32,
//                        child: Image.asset(menus[index].icon),
//                        ),
                    Text(menus[index].name),
                    Visibility(
                      visible: null != menus[index].msgCount &&
                          menus[index].msgCount > 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
//                          borderRadius: BorderRadiusGeometry.lerp(a, b, t)
                        ),
                      ),
                    ),
                    Expanded(child: nullableText(menus[index].info)),
                    Container(
                      width: 8,
                      height: 16,
                      child: Image.asset("images/right_arrow_gary.png"),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.black12,
              )
            ],
          ),
        );
      },
    );
  }

  Widget createHeader(dynamic data) {
//    var pic=data['userpic'];
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 18, top: 24, bottom: 12),
                  decoration: BoxDecoration(color: Colors.black12),
                  child: CircleAvatar(
                    radius: 24,
                    child: Image.network(
                      placeHolder(data, 'thumb'),
                      errorBuilder: (context, obj, strac) {
                        return Container(
                          width: 48,
                          height: 48,
                        );
                      },
                      width: 48,
                      height: 48,
                    ),
                  )),
              Text(placeHolder(data, 'user_name'))
            ],
          ),
//          Card(
//            margin: const EdgeInsets.only(left: 12,right: 12),
//            child:
          Container(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(placeHolder(data, 'credit')),
                    Text('学分')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(placeHolder(data, 'credit_rank')),
                    Text('积分排行榜')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(placeHolder(data, 'favorite_num')),
                    Text('收藏')
                  ],
                )
              ],
            ),
          ),
//          ),
        ],
      ),
    );
  }

  String placeHolder(dynamic data, String key) {
    if (null != data && null != data[key]) {
      return data[key].toString();
    } else {
      return '';
    }
  }
}
