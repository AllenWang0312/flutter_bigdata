

import 'package:bigdata/custom/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget{
  dynamic userinfo;
  SettingPage(this.userinfo);

  @override
  State<StatefulWidget> createState() {
   return _SettingPageState();
  }}
class _SettingPageState extends State<SettingPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leadingWidget: Icon(Icons.arrow_back_ios),
        title: "设置",
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 48,
            child: Row(

            ),
          )
        ],
      ),
    );
  }

}