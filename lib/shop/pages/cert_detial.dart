import 'dart:convert';

import 'package:bigdata/shop/pages/widgets/toolbar.dart';
import 'package:bigdata/shop/service/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CertDetailPage extends StatefulWidget {
  String cert_id;

  CertDetailPage(this.cert_id);

  @override
  CertDetailState createState() => CertDetailState(cert_id);
}

class CertDetailState extends State<CertDetailPage> {
  String cert_id;

  CertDetailState(this.cert_id);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Toolbar(
            title: '证书详情',
          ),
          Expanded(

            child: FutureBuilder(
              future: post('getCertDetail', formData: {'cert_id': cert_id}),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = json.decode(snapshot.data.toString());
                  print(cert_id);
                  print(data);
//                List<Map> banners = (data['data'] as List).cast();
                  return Text('name');
                } else {
                  return Container(
                    child: Text('加载中...'),
                  );
                }
              },
            ),
          ),
          bottom(),
        ],
      ),
    );
  }

  Widget bottom() {
    return Container(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('zixun.png'),
          Container(
            decoration: BoxDecoration(
//                borderRadius: BorderRadiusGeometry.lerp(a, b, t),
                color: Colors.blue),
            child: Text('试用',textAlign: TextAlign.center,),
          ),
          Container(
            child: Text('立即购买'),
          )
        ],
      ),
    );
  }
}
