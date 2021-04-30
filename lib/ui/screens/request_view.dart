import 'package:cached_network_image/cached_network_image.dart';
import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/p_request.dart';
import 'package:candix/ui/crumbs/button.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:candix/ui/crumbs/r_item.dart';
import 'package:candix/ui/screens/requestr.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

class RequestView extends StatelessWidget {
  static final String uri = "/request/view";

  @override
  Widget build(BuildContext context) {
    return CandixPage(
      "Procurement Request",
      leading: BackButton(),
      trailing: J.pr.current.value!.status == PRStatus.pending &&
              J.me!.id == J.pr.current.value!.staff!.id
          ? IconButton(
              onPressed: J.pr.deleting.value!
                  ? null
                  : () {
                      J.pr.delete();
                    },
              icon: J.pr.deleting.value!
                  ? SizedBox(
                      height: 20, width: 20, child: CircularProgressIndicator())
                  : Icon(PhosphorIcons.trash))
          : null,
      body: Obx(() => Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  RequestItem(
                    J.pr.current.value!,
                    main: true,
                  ),
                  Space.Y(20),
                  ListTile(
                    tileColor: Colors.white,
                    title: Text(
                        "${J.pr.current.value!.lineItems!.length} item${J.pr.current.value!.lineItems!.length == 1 ? "" : "s"}"),
                    subtitle: Text("Line items"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Space.Y(20),
                  ListTile(
                    tileColor: Colors.white,
                    title: Text(J.pr.current.value!.longDate),
                    subtitle: Text("Date requested"),
                  ),
                  Space.Y(20),
                  ListTile(
                    tileColor: Colors.white,
                    title: Text(J.pr.current.value!.time),
                    subtitle: Text("Time requested"),
                  ),
                ],
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Press.dark(
                      'Edit',
                      onPressed:
                          J.pr.current.value!.status != PRStatus.pending ||
                                  J.me!.id != J.pr.current.value!.staff!.id
                              ? null
                              : () => Get.toNamed(Requestr.uri),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
