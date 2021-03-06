import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/p_request.dart';
import 'package:candix/ui/screens/request_view.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class RequestItem extends StatelessWidget {
  final ProcurementRequest? r;
  final bool shimmer;
  final bool main;
  final Widget? trailing;

  RequestItem(this.r, {this.main = false, this.trailing}) : shimmer = false;

  RequestItem.shimmer()
      : r = null,
        main = false,
        trailing = null,
        shimmer = true;

  Color get _priority => r!.priority == PRPriority.high
      ? Color(0xFFD61C1C)
      : r!.priority == PRPriority.medium
          ? Color(0xFFD21CD6)
          : Color(0xFF938DEB);

  Color get _status => r!.status == PRStatus.rejected
      ? Color(0xFFD61C1C)
      : r!.status == PRStatus.approved || r!.status == PRStatus.processed
          ? Color(0xFF0E8E55)
          : Color(0xFFFA983E);

  IconData get _icon => r!.status == PRStatus.rejected
      ? PhosphorIcons.x
      : r!.status == PRStatus.approved || r!.status == PRStatus.processed
          ? PhosphorIcons.check
          : r!.status == PRStatus.reviewed
              ? PhosphorIcons.eye
              : PhosphorIcons.hourglass_medium_fill;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: shimmer
          ? null
          : () {
              J.pr.reset(r);
              Get.toNamed(RequestView.uri);
            },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ).add(EdgeInsets.only(left: !main ? 8 : 0)),
            padding: !main ? EdgeInsets.only(left: 30) : EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border(
                    left: !main
                        ? BorderSide(
                            width: 1, color: shimmer ? Colors.grey : _status)
                        : BorderSide.none)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                  color: shimmer ? Colors.transparent : Colors.white,
                  boxShadow: main
                      ? [
                          BoxShadow(
                              color: Colors.black.withOpacity(.04),
                              spreadRadius: 6,
                              blurRadius: 16)
                        ]
                      : [],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: shimmer ? Colors.grey : _priority,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Space.X(12),
                      if (shimmer)
                        Shimmer.fromColors(
                            child: Container(
                              width: 200,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[200]!)
                      else
                        Text(
                          r!.title!,
                          style: TextStyle(color: _priority),
                        )
                    ],
                  ),
                  Divider(),
                  Space.Y(10),
                  if (shimmer)
                    ...List.generate(
                        3,
                        (index) => Shimmer.fromColors(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 2),
                              width: 200,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            baseColor: Colors.grey[400]!.withOpacity(.5),
                            highlightColor: Colors.grey[300]!)).toList()
                  else
                    Text(r!.truncatedDescription!.replaceAll("\n", " ")),
                  Space.Y(20),
                  if (!shimmer) ...[
                    if (r!.staff?.id != J.me!.id) ...[
                      Row(children: [
                        Icon(PhosphorIcons.user),
                        Space.X(10),
                        Text(r!.staff!.name!)
                      ]),
                      Space.Y(8)
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Status",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            Space.X(10),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: (shimmer ? Colors.grey : _status)
                                      .withOpacity(.2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Text(
                                    r!.status!.val,
                                    style: TextStyle(
                                        color: _status,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Space.X(10),
                                  Icon(shimmer ? PhosphorIcons.ellipsis : _icon,
                                      color: shimmer ? Colors.black : _status)
                                ],
                              ),
                            )
                          ],
                        ),
                        if (trailing != null) trailing!
                      ],
                    )
                  ]
                ],
              ),
            ),
          ),
          if (!main)
            Container(
              padding: EdgeInsets.all(8),
              color: milder,
              child: (shimmer)
                  ? Shimmer.fromColors(
                      child: Container(
                        width: 30,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[200]!)
                  : Text(
                      r!.date,
                    ),
            )
        ],
      ),
    );
  }
}
