import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/p_request.dart';
import 'package:candix/ui/crumbs/404.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:candix/ui/crumbs/r_item.dart';
import 'package:candix/ui/screens/requestr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../utils.dart';

class Requests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CandixPage(
      "Requests",
      trailing: IconButton(
        icon: Icon(PhosphorIcons.bell),
        onPressed: () {},
      ),
      body: Stack(
        children: [
          Obx(() => RefreshIndicator(
                onRefresh: () async {
                  await J.pr.fetchRequests(subtle: true);
                },
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    if (J.pr.loading.value!) ...[
                      RequestItem.shimmer(),
                      RequestItem.shimmer(),
                      RequestItem.shimmer(),
                    ] else if (J.pr.requests.isEmpty) ...[
                      Space.Y(50),
                      Center(
                        child: NotFound("No Requests found"),
                      )
                    ],
                    for (ProcurementRequest r in J.pr.requests) RequestItem(r),
                    Space.Y(50)
                  ],
                ),
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FloatingActionButton(
                onPressed: () {
                  J.pr.reset();
                  Get.toNamed(Requestr.uri);
                },
                child: Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}
