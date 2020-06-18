import 'dart:convert';

import '../../custom/widgets/banner.dart';
import '../../custom/widgets/custom_appbar.dart';
import '../route/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/index.dart';
import '../service/http_service.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../config/color.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;

  HomePage(this.scaffoldKey);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('首页刷新了');
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Scaffold(
        key: widget.scaffoldKey,
        backgroundColor: KColor.background,
        appBar: CustomAppbar(
          title: "主页",
          leadingWidget: InkWell(
            onTap: () {
              widget.scaffoldKey.currentState.openDrawer();
            },
            child: Icon(Icons.widgets),
          ),
          trailingWidget: InkWell(
            child: Text("了解更多"),
            onTap: () {
              var url = "/web?url=" +
                  Uri.encodeComponent(know_more) +
                  "&title=" +
                  Uri.encodeComponent("了解更多");
              print(url);
              MyApp.router.navigateTo(
                context,
                url,
                transition: TransitionType.fadeIn,
              );
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            FutureBuilder(
              future: get('getBannerData', formData: {"type": 2}),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = json.decode(snapshot.data.toString());
                  print(data);
                  List<Map> banners = (data['data'] as List).cast();
                  return BannerView(banners);
                } else {
                  return Container(
                    child: Text('加载中...'),
                  );
                }
              },
            ),
            FutureBuilder(
              future: post('getClassList', formData: {"class_id": 1}),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = json.decode(snapshot.data.toString());
                  List<Map> list = (data['data'] as List).cast();
                  print(list);
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return classItem(list[index])
//                    Text(list[index]['name'])
                          ;
                    },
                    itemCount: list.length,
                    shrinkWrap: true, //height warp
                    physics: const NeverScrollableScrollPhysics(), //禁止滑动
                  );
                } else {
                  return Container(
                    child: Text('加载中...'),
                  );
                }
              },
            ),
          ],
        ));
  }

  Widget classItem(Map<dynamic, dynamic> item) {
    return IntrinsicHeight(
        child: InkWell(
      onTap: () {
        var cert_id = item['id'];
        var route = "${Routes.certDetail}?cert_id=$cert_id";
        print(route);
        MyApp.router.navigateTo(
          context,
//Routes.certDetail,
          route,
          transition: TransitionType.fadeIn,
        );
      },
      child: Column(
        children: <Widget>[
          Image.network(item['m_picture']),
          Text(item['name']),
          Text(item['tag'])
        ],
      ),
    ));
  }
}

class MyDrawer extends StatelessWidget {
  List<Widget> group(Map item) {
    return null;
  }

  List<Widget> groups(List groups) {
    var widgets = List();
    groups.map((e) => widgets.addAll(group(e)));
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: post("mv2/cert/class"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.toString());
            Map data = json.decode(snapshot.data.toString());
            return ListView(
              children: groups(data['data']),
            );
          } else {
            return Text('加载中');
          }
        });
  }
}
