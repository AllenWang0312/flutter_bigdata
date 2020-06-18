import 'dart:convert';

import 'package:flutter/material.dart';
import '../service/http_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: get('queryApps', formData: {'userId': 36}),
      builder: (context, snapshut) {
        if (snapshut.hasData) {
          var result = json.decode(snapshut.data.toString());
          List applist = result['data']['applist'];

          return GridView.builder(
              itemCount: applist.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //横轴元素个数
                  crossAxisCount: 3,
                  //纵轴间距
                  mainAxisSpacing: 20.0,
                  //横轴间距
                  crossAxisSpacing: 10.0,
                  //子组件宽高长度比例
                  childAspectRatio: 1.0),
              itemBuilder: (BuildContext context, int index) {
                //Widget Function(BuildContext context, int index)
                return Column(
                  children: <Widget>[
//                Image.network(applist[index][]);
                    Text(applist[index]['name']),
                  ],
                );
              });
        } else {
          return Text('加载中');
        }
      },
    );
  }
}
