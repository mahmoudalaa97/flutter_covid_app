import 'package:covid21/logic/network/api_strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static Dio? _dio;

  static init() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiStrings.baseUrl,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
      headers: {"Content-Type": "application/json"},
    ));
  }

  static Future<Response?> getData(
      {@required String? path,
      Map<String, dynamic>? query,
      Map<String, dynamic>? headers}) async {
    return await _dio?.get(path!,
        queryParameters: query, options: Options(headers: headers));
  }

  static Future<Response?> postData({
    @required String? path,
    dynamic data,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio?.post(path!,
        data: data,
        options: options,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress);
  }
}
