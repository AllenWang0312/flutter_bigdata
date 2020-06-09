import 'dart:convert';

import 'package:bigdata/shop/pages/widgets/banner.dart';
import 'package:bigdata/shop/route/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bigdata/shop/config/index.dart';
import 'package:bigdata/shop/service/http_service.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../config/color.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  var _footerKey = GlobalKey<RefreshFooterState>();

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
      backgroundColor: KColor.background,
      appBar: AppBar(
        title: Text(KString.homeTitle),
      ),
      drawer: MyDrawer(),
      body: EasyRefresh(
        refreshFooter: ClassicsFooter(
          key: _footerKey,
          bgColor: Colors.white,
          textColor: KColor.refreshTextColor,
          moreInfoColor: KColor.refreshTextColor,
          showMore: true,
          noMoreText: "我是有底线的",
          moreInfo: KString.loading,
          loadReadyText: KString.loadReadyText,
        ),
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: get('getBannerData', formData: {"type": 2}),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = json.decode(snapshot.data.toString());
                  print(data);
                  List<Map> banners = (data['data'] as List).cast();
                  return SwiperDiy(banners);
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
                  return ListView.builder(itemBuilder: (context, index) {
                    return
                      classItem(list[index])
//                    Text(list[index]['name'])
                    ;
                  },
                    itemCount: list.length,
                  shrinkWrap: true,);
                } else {
                  return Container(
                    child: Text('加载中...'),
                  );
                }
              },
            ),
          ],
        ),
        loadMore: () async {},
      ),
    );
  }

  Widget classItem(Map<dynamic, dynamic> item) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: (){
          var cert_id=item['id'];
          var route="${Routes.certDetail}?cert_id=$cert_id";
          print(route);
          MyApp.router.navigateTo(context,
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
      )
    );
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
            return null;
          }
        });
  }
}
