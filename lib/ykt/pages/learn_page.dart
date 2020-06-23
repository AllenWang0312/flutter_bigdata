import 'dart:convert';

import 'package:bigdata/custom/widgets/custom_appbar.dart';
import 'package:bigdata/ykt/config/http_conf.dart';

import '../main.dart';
import '../service/http_service.dart';
import 'package:flutter/material.dart';

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> with TickerProviderStateMixin {
  TabController mController;

  var selectIndex = 0;
  List<dynamic> certs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          post("getCertListForLearn", formData: {'user_ticket': MyApp.token}),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = json.decode(snapshot.data.toString());
          if (hasError(data, context)) {
            return emptyView('发生错误');
          } else {
            certs = data['data'];
            mController = TabController(
              length: certs.length,
              vsync: this,
            );
            return Scaffold(
              appBar: AppBar(
                title: _tabBar(certs),
              ),
              body: _tabBarView(),
            );
          }
        } else {
          return emptyView('加载中');
        }
      },
    );
  }

  Widget _tabBarView() {
    return TabBarView(
      controller: mController,
      children: certs.map((item) {
        return FutureBuilder(
          future: post('getCourseInfo', formData: {
            'user_ticket': MyApp.token,
            'cert_id': item['cert_id']
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var rsp = json.decode(snapshot.data.toString());
              if (hasError(rsp, context)) {
                return Text('请求出错');
              } else {
                var data = rsp['data'];
                List lecture = data['lectureInfo'];
                print(data);
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 64,
                            child: Stack(
                              children: <Widget>[],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.info,
                                semanticLabel: '考试',
                              ),
                              Icon(
                                Icons.info,
                                semanticLabel: '测试',
                              ),
                              Icon(
                                Icons.info,
                                semanticLabel: '考试',
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Container(
                          color: Colors.red,
                          height: 24,
                          child: Row(
                            children: <Widget>[
                              Text(lecture[index]['name']),
                            ],
                          ),
                        );
                      }, childCount: lecture.length),
                      itemExtent: 48.0,
                    )
                  ],
                );
              }
            } else {
              return Text('加载中');
            }
          },
        );
      }).toList(),
    );
  }

  Widget _tabBar(List<dynamic> certs) {
    return TabBar(
      isScrollable: true,
      controller: mController,
      indicator: UnderlineTabIndicator(),
      tabs: certs.map((item) {
        return Tab(
          text: item['custom_name'],
        );
      }).toList(),
    );
  }

  Widget emptyView(String msg) {
    return Text(msg);
  }
}
