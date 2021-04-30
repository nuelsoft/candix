import 'dart:io';

import 'package:candix/core/models/line_item.dart';
import 'package:candix/core/models/p_request.dart';
import 'package:candix/core/services/_api.dart';
import 'package:candix/core/services/functions.dart';
import 'package:candix/core/services/p_request.dart';
import 'package:candix/ui/screens/request_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProcurementRequestController extends GetxController {
  RxList<ProcurementRequest> requests = RxList<ProcurementRequest>([]);

  RxBool loading = false.obs;
  RxBool saving = false.obs;
  RxBool deleting = false.obs;

  Rx<int?> totalStat = Rx<int?>(null);
  Rx<int?> approvedStat = Rx<int?>(null);

  RxList<Rx<LineItem>> lineItems = RxList<Rx<LineItem>>([]);

  Future<void> fetchRequests({bool subtle = false}) async {
    if (!subtle) loading.value = true;
    NetworkResponse res = await ProcurementService().getRequests();

    if (res.succeed)
      requests.value = ProcurementRequest.many(List<Map<String, Object?>>.from(
          (res.data as Map<String, Object?>)["data"] as Iterable));
    fetchStats();

    if (!subtle) loading.value = false;
  }

  Future<void> fetchStats() async {
    NetworkResponse res = await ProcurementService().getStats();
    if (res.succeed) {
      totalStat.value = (res.data as Map<String, dynamic>)["data"]["total"];
      approvedStat.value =
          (res.data as Map<String, dynamic>)["data"]["approved"];
    }
  }

  Rx<ProcurementRequest?> current = Rx<ProcurementRequest>(null);

  TextEditingController? title;
  TextEditingController? desc;

  Rx<PRPriority>? urgency;

  Rx<File?> image = Rx<File?>(null);
  Rx<String?> imageUrl = Rx<String?>(null);

  Future<void> submitRequest() async {
    saving.value = true;
    NetworkResponse res =
        await ProcurementService().push((current.value ?? ProcurementRequest())
          ..title = title!.text
          ..description = desc!.text
          ..lineItems = lineItems.map((item) => item.value!).toList()
          ..priority = urgency!.value);

    if (res.succeed) {
      fetchRequests(subtle: false);
      fetchStats();

      if (current.value == null) {
        reset(ProcurementRequest.form((res.data as Map<String, Object?>)["data"]
            as Map<String, Object?>));

        Get.offNamed(RequestView.uri);
      } else {
        await Future.delayed(Duration(milliseconds: 700));
        Get.back(closeOverlays: true);
      }
    }

    saving.value = false;
  }

  Future<void> delete() async {
    deleting.value = true;
    Get.snackbar("Running", "Deleting Request");
    await ProcurementService().remove(current.value!.id!);
    fetchRequests(subtle: true);
    fetchStats();
    await Future.delayed(Duration(milliseconds: 700));
    deleting.value = false;
    Get.back(closeOverlays: true);
  }

  reset([ProcurementRequest? r]) {
    current.value = r;
    title = TextEditingController(text: current.value?.title);
    desc = TextEditingController(text: current.value?.description);
    urgency = (current.value?.priority ?? PRPriority.low).obs;
    image = Rx<File?>(null);
    imageUrl.value = (r?.images?.isNotEmpty ?? false) ? r!.images!.first : null;
    lineItems.value = [];
  }
}
