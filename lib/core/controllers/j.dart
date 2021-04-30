import 'package:candix/core/controllers/auth.dart';
import 'package:candix/core/controllers/global.dart';
import 'package:candix/core/controllers/line_itemr.dart';
import 'package:candix/core/controllers/p_request.dart';
import 'package:candix/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class J extends GetxController {
  static register() {
    Get.put(Authenticator());
    Get.put(GlobalController());
    Get.put(ProcurementRequestController());
    Get.put(LineItemController());
  }

  static User? get me => auth.currentUser?.value;

  static Map<String, String> get authorization {
    print(auth.token);
    return {"Authorization": "Bearer ${auth.token}"};
  }

  static Authenticator get auth => Get.find();

  static GlobalController get global => Get.find();

  static ProcurementRequestController get pr => Get.find();

  static LineItemController get li => Get.find();

  static void error(String e) {
    Get.snackbar("Error", e,
        colorText: Colors.white, backgroundColor: Colors.red, barBlur: 5);
  }
}
