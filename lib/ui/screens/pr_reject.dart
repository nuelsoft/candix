import 'package:candix/core/controllers/j.dart';
import 'package:candix/ui/crumbs/button.dart';
import 'package:candix/ui/crumbs/input.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RejectionScreen extends StatelessWidget {
  static final String uri = "/rejection";

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CandixPage(
        'Decline Request',
        filled: false,
        leading: BackButton(),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add decline note (optional)"),
            ),
            Space.Y(4),
            Input.multi(
              'Note',
              controller: J.pr.note,
            ),
            Space.Y(50),
            Press.dark(
              'Decline',
              loading: J.pr.rejecting.value!,
              onPressed: () {
                J.pr.react(false).then((value) {
                  Get.back();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
