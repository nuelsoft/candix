import 'package:cached_network_image/cached_network_image.dart';
import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/p_request.dart';
import 'package:candix/ui/crumbs/button.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:candix/ui/crumbs/r_item.dart';
import 'package:candix/ui/screens/pr_accept.dart';
import 'package:candix/ui/screens/pr_line_items.dart';
import 'package:candix/ui/screens/pr_reject.dart';
import 'package:candix/ui/screens/requestr.dart';
import 'package:candix/ui/screens/view_notes.dart';
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
              RefreshIndicator(
                onRefresh: () async {
                  await J.pr.refreshCurrent();
                },
                child: ListView(
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "₦ " + J.pr.current.value!.totalAmount.format,
                            style: TextStyle(fontSize: 17),
                          ),
                          Space.X(5),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      onTap: () {
                        Get.toNamed(ProcurementRequestLineItems.uri);
                      },
                    ),
                    Space.Y(20),
                    ListTile(
                      tileColor: Colors.white,
                      title: Text('Notes'),
                      subtitle: Text("Procurement Timeline"),
                      trailing: J.pr.loadingNotes.value == true
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator())
                          : Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        if (J.pr.notes.isEmpty)
                          return J
                              .info("No notes attached to this request yet!");

                        Get.toNamed(AllNotes.uri);
                      },
                    ),
                    Space.Y(20),
                    ListTile(
                      tileColor: Colors.white,
                      title: Text(
                          '${J.pr.current.value!.longDate} - ${J.pr.current.value!.time}'),
                      subtitle: Text("Date requested"),
                    ),
                    Space.Y(20),
                    if (J.pr.current.value!.isReviewed) ...[
                      ListTile(
                        tileColor: Colors.white,
                        title: Text(J.pr.current.value!.reviewedBy?.name ??
                            'Unspecified'),
                        subtitle: Text(
                          "Reviewing Supervisor",
                        ),
                      ),
                      Space.Y(20),
                    ],
                    if ([PRStatus.approved, PRStatus.processed]
                        .contains(J.pr.current.value!.status)) ...[
                      ListTile(
                        tileColor: Colors.white,
                        title: Text(J.pr.current.value!.approvedBy?.name ??
                            'Unspecified'),
                        subtitle: Text(
                          "Reviewing HOD",
                        ),
                      ),
                      Space.Y(20)
                    ],
                    if (J.pr.current.value!.status != PRStatus.rejected &&
                        ((J.me!.isHOD &&
                                ![PRStatus.approved, PRStatus.processed]
                                    .contains(J.pr.current.value!.status)) ||
                            J.me!.isSupervisor &&
                                ![
                                  PRStatus.approved,
                                  PRStatus.processed,
                                  PRStatus.reviewed,
                                ].contains(J.pr.current.value!.status)))
                      ListTile(
                        tileColor: Colors.white,
                        title: Text(
                          'Approve',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Promote to ${J.me!.isHOD ? 'Processing' : 'HOD'}",
                        ),
                        trailing: SizedBox(
                            child: J.pr.accepting.value!
                                ? CircularProgressIndicator()
                                : J.me!.isHOD
                                    ? Icon(Icons.arrow_forward_ios)
                                    : Container(),
                            width: 20,
                            height: 20),
                        onTap: () {
                          J.pr.note.clear();
                          if (J.me!.isHOD) J.pr.getProjects();
                          Get.toNamed(AcceptPR.uri);
                        },
                      ),
                    if ((J.me!.isSupervisor &&
                            !J.pr.current.value!.isReviewed) ||
                        ![
                          PRStatus.approved,
                          PRStatus.processed,
                          PRStatus.rejected
                        ].contains(J.pr.current.value!.status)) ...[
                      Space.Y(20),
                      ListTile(
                        tileColor: Colors.white,
                        title: Text(
                          'Decline Request',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          J.pr.note.clear();
                          Get.toNamed(RejectionScreen.uri);
                        },
                      ),
                      Space.Y(40)
                    ],
                  ],
                ),
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
                              : () {
                                  J.pr.reset(J.pr.current.value!);
                                  Get.toNamed(Requestr.uri);
                                },
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
