import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final double contentHeight;
  Color navigationBarBackgroundColor;
  Widget leadingWidget;
  Widget trailingWidget;
  String title;

  CustomAppbar({
   this.leadingWidget,
    this.title="",
    this.contentHeight = 44,
    this.navigationBarBackgroundColor = Colors.white,
    this.trailingWidget,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomAppbarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(contentHeight);
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.navigationBarBackgroundColor,
      child: SafeArea(
        top: true,
        child: new Container(
          decoration: UnderlineTabIndicator(
            borderSide: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
          ),
          height: widget.contentHeight,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: 0,
                child: Container(
                  child: widget.leadingWidget,
                  padding: const EdgeInsets.only(left: 5),
                ),
              ),
              Container(
                child: new Text(
                  widget.title,
                  style: TextStyle(fontSize: 17, color: Color(0xFF333333)),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  child: widget.trailingWidget,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
