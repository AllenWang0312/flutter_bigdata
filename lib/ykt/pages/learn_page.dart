import 'dart:convert';

import 'package:bigdata/ykt/config/http_conf.dart';

import '../main.dart';
import '../service/http_service.dart';
import 'package:flutter/material.dart';

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  var selectIndex = 0;
  List<dynamic> certs;
  List<Tab> tabs = [];

  List<Tab> initTabs() {
    tabs.clear();
    for (var i in certs) {
      tabs.add(Tab(text: i['name']));
    }
    return tabs;
  }

  @override
  void initState() {
//    initData();
//    initTabs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//     TabController controller=TabController();
    return Scaffold(
//              appBar: AppBar(
//                bottom: TabBar(
//                  tabs: initTabs(),
//                  controller: controller,
//                  isScrollable: true,
//                  indicatorColor: Color(0xffff0000),
//                  indicatorWeight: 1,
//                  indicatorSize: TabBarIndicatorSize.tab,
//                  indicatorPadding: EdgeInsets.only(bottom: 10.0),
//                  labelPadding: EdgeInsets.only(left: 20),
//                  labelColor: Color(0xff333333),
//                  labelStyle: TextStyle(
//                    fontSize: 15.0,
//                  ),
//                  unselectedLabelColor: Color(0xffffffff),
//                  unselectedLabelStyle: TextStyle(
//                    fontSize: 12.0,
//                  ),
//                ),
//              ),
        body: Text('加载中${certs.length}'));
  }

  initData() async {
    var resp = await post("getCertListForLearn",
        formData: {'user_ticket': MyApp.token});
    var data = json.decode(resp.toString());
    certs = data['data'];
  }
}
