import 'dart:convert';

import 'package:bigdata/shop/main.dart';
import 'package:bigdata/shop/service/http_service.dart';
import 'package:flutter/material.dart';

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {

  var selectIndex = 0;
  List<Map> certs;
  List<Tab> tabs = [];

  List<Tab> initTabs() {
    tabs.clear();
    for (var i in certs) {
      tabs.add(Tab(text: i['name']));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    FutureBuilder(
      future: post(
          "getCertListForLearn", formData: {'user_ticket': MyApp.token}),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = json.decode(snapshot.data.toString());
          certs = (data['data'] as List).cast();

          return Scaffold(
              appBar: AppBar(
                bottom: TabBar(tabs: initTabs(),),
              ),
              body: FutureBuilder(
                future: post(
                    "getCourseLearnGson", formData: {
                  'user_ticket': MyApp.token,
                  'cert_id': certs[selectIndex]['cert_id'],
                  'is_audition': 0
                }),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = json.decode(snapshot.data.toString());
//                    var  = (data['data'] as List).cast();
                    print(data);
                  } else {

                  }
                  return Text('加载中');
                },
              )
          );
        } else {
          return Text("加载中");
        }
      },
    );
  }

}
