import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

class ApiHelper extends GetConnect {
  static final ApiHelper instance = ApiHelper.init();

  factory ApiHelper() => instance;

  ApiHelper.init();

  static const contentType = "application/json; charset=utf-8";

  @override
  void onInit() {
    super.onInit();
    Get.log("init called", isError: false);

    httpClient.timeout = const Duration(seconds: 60);
    httpClient.maxAuthRetries = 3;
  }

  // generic Function to get data
  Future<Map<String, dynamic>> getData(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
  }) async {
    Map<String, dynamic> responseMap = {'status': false, 'msg': '', 'data': ''};
    int statusCode = 00;
    try {
      var response = await get(url, query: query, contentType: contentType);
      Get.log("response body ${response.body}");
      statusCode = response.statusCode ?? 00;
      String? mResponse = response.bodyString;
      Get.log(" $statusCode $mResponse");
      Map<String, dynamic> map = json.decode(mResponse!);
      if (statusCode >= 200 && statusCode <= 300) {
        responseMap['status'] = true;
        responseMap['status-code'] = map['status-code'];
        responseMap['data'] = map;
        return responseMap;
      } else {
        responseMap['status'] = false;
        responseMap['status-code'] = map['status-code'];
        responseMap['data'] = map;
        return responseMap;
      }
    } on SocketException {
      responseMap['code'] = statusCode;
      responseMap['status'] = false;
      responseMap['msg'] = 'No Internet Connectivity';
    } catch (e) {
      responseMap['code'] = statusCode;
      responseMap['status'] = false;
      responseMap['msg'] = 'Please try again later';

      return responseMap;
    }
    return responseMap;
  }
}
