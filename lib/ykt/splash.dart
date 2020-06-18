import 'dart:async';
import 'dart:convert';

import 'route/routes.dart';
import 'service/http_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends State<SplashPage> {
  String _cover = '';

  Timer _countdownTimer;

//  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 5;

  @override
  void initState() {
    print('initState');
    reGetCountdown();
    if (MyApp.token.isNotEmpty) {
      post('tokenLogin', formData: {"user_ticker": MyApp.token}).then((
          value) => {
      });
    } else {

    }
    super.initState();
  }

  void reGetCountdown() {
    setState(() {
      if (_countdownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
//      _codeCountdownStr = '${}重新获取';
      _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _countdownNum--;
            print('timer');
//            _codeCountdownStr = '${_countdownNum--}重新获取';
          } else {
//            _codeCountdownStr = '获取验证码';
            _countdownTimer.cancel();
            _countdownTimer = null;
            jump();
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          background(),
          Align(
              alignment: Alignment.bottomRight,
              child: SafeArea(
                minimum: EdgeInsets.all(12),
                child: Container(
                  alignment: Alignment.center,
                  constraints:
                  BoxConstraints(minWidth: 24, maxHeight: 24, maxWidth: 64),
                  decoration: new BoxDecoration(
//                    border: new Border.all(width: 2.0, color: Colors.red),
                    color: Colors.grey,
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(12.0)),
//                    image: new DecorationImage(
//                      image: new NetworkImage(
//                          'http://h.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=0d023672312ac65c67506e77cec29e27/9f2f070828381f30dea167bbad014c086e06f06c.jpg'),
//                      centerSlice:
//                          new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
//                    ),
                  ),
                  child: Text(
                    '跳过(${_countdownNum}s)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget back;

  Widget background() {
    if (null == back) {
      return FutureBuilder(
        future: get('getBannerData'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> banners = (data['data'] as List).cast();
            _cover = banners[0]['imageurl'];
            print(_cover);
            back = CachedNetworkImage(
              imageUrl: _cover,
//                    placeholder: (context, url) => CircularProgressIndicator(),
//                    errorWidget: (context, url, error) => Icon(Icons.error),
            );
            return back;
          } else {
            return Text('');
          }
        },
      );
    } else {
      return back;
    }
  }

  void jump() {
    if (MyApp.token.isNotEmpty) {
      MyApp.router.navigateTo(context, Routes.index,
          transition: TransitionType.fadeIn,
//                clearStack: true,
          replace: true);
    } else {
      MyApp.router.navigateTo(context, Routes.login,
          transition: TransitionType.fadeIn,
//                clearStack: true,
          replace: true);
    }
  }
}
