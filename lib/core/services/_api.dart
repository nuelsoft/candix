import 'package:flutter/material.dart';
import 'package:get/get.dart';

class API extends GetConnect {

  String get base => "https://candix-erp.herokuapp.com";

  String uri(String u) {
    return '$base/api/$u';
  }

  NetworkResponse parse(Response r, {String? message}) {
    print(r.body);
    return NetworkResponse(
        r.body is String || r.statusCode.toString().startsWith('5')
            ? {
                "error": true,
                "errors": {
                  "server": ["Server couldn't could. Try again later"]
                }
              }
            : r.body,
        r.statusCode)
      ..log(message);
  }
}

class NetworkResponse {
  bool succeed;
  String? generalMessage;
  List<dynamic>? errors;
  Object? data;
  int? code;
  Map<String, dynamic>? response;

  NetworkResponse(Map<String, dynamic>? res, [this.code])
      : succeed = res?["error"] == false || res?["error"] == null && res?["success"] != false,
        generalMessage = res?["message"],
        errors = res?["errors"] is List && res?["success"] == false
            ? [res?["message"]]
            : (res?["errors"]?.values.toList())?[0],
        data = res,
        response = res;

  String get firstError =>
      errors != null ? errors![0] as String : "Please check your internet";

  void log([String? message]) {
    if (!succeed) {
      print("[$code] $generalMessage \n$errors");
      // Get.snackbar("Error", firstError,
      //     backgroundColor: Colors.red, colorText: Colors.white);
    }else if (message != null) {
      // Get.snackbar("Success", message,
      //     backgroundColor: Colors.green, colorText: Colors.white);
    }
  }
}
