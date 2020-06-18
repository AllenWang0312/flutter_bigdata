import 'dart:io';

import 'package:dio/dio.dart';
import '../config/http_conf.dart';

Future get(key, {formData}) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = 'application:x-www-form-urlencode';
    if (formData == null) {
      response = await dio.get(servicePath[key]);
    } else {
      response = await dio.get(servicePath[key], queryParameters: formData);
    }
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后端接口异常,请检查代码');
    }
  } catch (e) {
    print('error:::${e}');
  }
}

Future post(key, {formData}) async {
  try {
    Response response;
    Dio dio = new Dio();
//    dio.options.contentType = 'application:x-www-form-urlencode';
    if (formData == null) {
      response = await dio.post(servicePath[key]);
    } else {
      response = await dio.post(servicePath[key], data: formData);
    }
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后端接口异常,请检查代码');
    }
  } catch (e) {
    print('error:::${e}');
  }
}

 abstract class NESubscriber {
  dynamic response;

  NESubscriber(this.response){

  }

  onSuccess(dynamic data){

  }
  onError(Error error);

  onComplate();
}
