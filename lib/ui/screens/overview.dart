import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/p_request.dart';
import 'package:candix/ui/crumbs/404.dart';
import 'package:candix/ui/crumbs/button.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:candix/ui/crumbs/r_item.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CandixPage(
      "Overview",
      trailing: IconButton(
        icon: Icon(PhosphorIcons.bell),
        onPressed: () {},
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await J.pr.fetchRequests(subtle: true);
        },
        child: Obx(() => ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      children: [
                        for (Map<String, dynamic> card in [
                          {
                            "icon": PhosphorIcons.bag_simple,
                            "color": Color(0xFF0D00CA),
                            "title": "Total Request",
                            "value": J.pr.totalStat.value ?? "_"
                          },
                          {
                            "icon": PhosphorIcons.suitcase,
                            "color": Color(0xFF1CD080),
                            "title": "Approved",
                            "value": J.pr.approvedStat.value ?? "_"
                          }
                        ])
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: .55.ofWidth,
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: (card["color"] as Color)
                                              .withOpacity(.3),
                                        ),
                                        child: Icon(card["icon"],
                                            color: card["color"]),
                                      ),
                                      Space.X(15),
                                      Expanded(
                                          child: Text(
                                        card["title"],
                                        style: TextStyle(
                                            color: card["color"], fontSize: 16),
                                      ))
                                    ],
                                  ),
                                  Text(
                                    card["value"].toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ))
                      ],
                    )),
                Space.Y(10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.notepad,
                        color: primary,
                      ),
                      Space.X(10),
                      Text(
                        "Recent Requests",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                ),
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
                for (ProcurementRequest r in J.pr.requests.length < 5
                    ? J.pr.requests
                    : J.pr.requests.sublist(0, 4))
                  RequestItem(r),
                Space.Y(10),
                if (J.pr.requests.length > 4) ...[
                  Press.dark(
                    'View more',
                    onPressed: () {
                      J.global.currentHomeIndex.value = 2;
                    },
                  ),
                  Space.Y(30)
                ]
              ],
            )),
      ),
    );
  }
}
