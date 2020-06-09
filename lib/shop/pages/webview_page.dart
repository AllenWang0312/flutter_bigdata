import 'package:flutter/cupertino.dart';

class WebViewPage extends StatefulWidget {
  String title;
  String url;
  WebViewPage(this.url, this.title);

  @override
  _WebViewState createState() {
   return _WebViewState();
  }
}

class _WebViewState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Text("WebViewPage");
  }
}
