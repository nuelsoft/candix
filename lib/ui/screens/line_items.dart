import 'package:cached_network_image/cached_network_image.dart';
import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/p_request.dart';
import 'package:candix/ui/crumbs/button.dart';
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
    return Scaffold(
      backgroundColor: milder,
      body: Obx(() => Stack(
        children: [
          Container(
            height: .4.ofHeight,
            width: double.infinity,
            color: mild,
            child: J.pr.current.value?.images?.isEmpty ?? true
                ? Center(
              child: Icon(
                PhosphorIcons.image,
                size: 50,
                color: primary,
              ),
            )
                : CachedNetworkImage(
              imageUrl: J.pr.current.value!.images!.first,
              fit: BoxFit.cover,
              placeholder: (context, _) =>
                  Center(child: CircularProgressIndicator()),
            ),
          ),
          Column(
            children: [
              Space.Y(.4.ofHeight - 70),
              RequestItem(J.pr.current.value!,
                  main: true,
                  trailing: J.pr.current.value!.status ==
                      PRStatus.pending &&
                      J.me!.id == J.pr.current.value!.staff!.id
                      ? IconButton(
                      onPressed: J.pr.deleting.value! ? null : () {
                        J.pr.delete();
                      },
                      icon: J.pr.deleting.value!
                          ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator())
                          : Icon(PhosphorIcons.trash,
                          color: Colors.red))
                      : null),
              Space.Y(.15.ofHeight),
              Text(
                J.pr.current.value!.longDate,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "DATE REQUESTED",
                style: TextStyle(color: Colors.grey),
              )
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
          SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  child: BackButton(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: milder,
                  ),
                ),
              ))
        ],
      )),
    );
  }
}
