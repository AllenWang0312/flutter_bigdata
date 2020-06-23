import '../route/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

const base_url = 'https://api.9first.com//';

const servicePath = {
  //post
  'tokenLogin': base_url + 'mv2/user/index/login-info',
  'accountLogin': base_url + 'authorization/client/login',
  'getCertListForLearn': base_url + 'mv2/user/course/cert-list',
  'getCourseLearnGson': base_url + 'mv2/user/course/learn-course',
  'getMineInfo': base_url + 'mv2/user/info/personhome',
  //get
  'getBannerData': base_url + 'mv2/home/topad',
  'getUserInfo': base_url + 'mv2/user/info/detail',
  'getClasses': base_url + 'mv2/cert/class',
  'getClassList': base_url + 'mv2/cert/list',
  'getCertDetail': base_url + 'mv2/cert/detail',
  'getCourseInfo': base_url+'mv2/user/course/list',
//  'getUserInfo':base_url+'mv2/user/info/detail',
//  'getUserInfo':base_url+'mv2/user/info/detail',
};

const h5_host = "https://special.9first.com";
const know_more = h5_host + "/special/9first_app/h5/more/";

bool hasError(dynamic data, BuildContext context) {
  var hasError = false;
  var status = data['status'];
  var errCode = data['errCode'];
  var errMsg = data['errMsg'];
  if (null != errMsg && errMsg.toString().isNotEmpty) {
    Fluttertoast.showToast(msg: errMsg);
    hasError = true;
  }
  if (null!=errCode && errCode.toString() == "2002") {
    MyApp.router.pop(context);
    MyApp.router.navigateTo(context, Routes.login);
    hasError = true;
  }
  if (status != 1) {
    hasError = true;
  }
  return hasError;
}
