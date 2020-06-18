import 'dart:convert';

import '../service/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppsPage extends StatefulWidget {
  @override
  _AppsPageState createState() {
    return _AppsPageState();
  }
}

class _AppsPageState extends State<AppsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: Appbar(),
      body: FutureBuilder(
        future: post('getClassList', formData: {"class_id": 1}),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> list = (data['data'] as List).cast();
            return SingleChildScrollView(
              child: ListView.builder(itemBuilder: (context, index) {
                return inflateItem(list[index]);
              },itemCount: list.length,),
            );
          } else {
            return Container(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }

  inflateItem(Map<String, dynamic> item) {
    return Column(
      children: <Widget>[
        Text(item['']),
      ],
    );
  }
}
