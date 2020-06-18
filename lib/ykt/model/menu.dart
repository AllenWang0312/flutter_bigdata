import 'package:flutter/cupertino.dart';

class Menu {
  String name;
  String icon;
  int msgCount = 0;
  String info= " ";
  bool more = false;
  Function onTap;

  Menu(
      {@required this.name,
      this.icon,
      this.msgCount,
      this.info ,
      this.more,
      this.onTap});
}
