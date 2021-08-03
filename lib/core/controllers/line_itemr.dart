import 'dart:io';

import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/line_item.dart';
import 'package:candix/core/services/_api.dart';
import 'package:candix/core/services/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LineItemController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  Rx<String?> url = Rx<String>(null);
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController qty = TextEditingController(text: "1");
  TextEditingController price = TextEditingController(text: "0");

  RxBool working = false.obs;

  Future<LineItem?> validate() async {
    // if (image.value == null && url.value == null) {
    //   J.error("Please select an image");
    //   return null;
    // }
    if (image.value != null) {
      working.value = true;
      NetworkResponse upload = await FunctionService().upload([image.value!]);
      if (upload.succeed == true) {
        url.value = (Map<String, dynamic>.from(
                upload.data as Map<String, dynamic>)["data"]
            .first["url"] as String);
      }
    }

    working.value = false;

    return LineItem()
      ..price = double.tryParse(price.text)
      ..qty = int.tryParse(qty.text)
      ..title = title.text
      ..description = desc.text
      ..image = url.value;
  }

  void reset([LineItem? item]) {
    working.value = false;
    image.value = null;
    url.value = item?.image ?? null;
    title.text = item?.title ?? "";
    desc.text = item?.description ?? "";
    qty.text = (item?.qty ?? "1").toString();
    price.text = (item?.price ?? "0").toString();
  }
}
