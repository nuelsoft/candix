import 'package:cached_network_image/cached_network_image.dart';
import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/line_item.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProcurementRequestLineItems extends StatelessWidget {
  static final uri = "pr/line_items";

  @override
  Widget build(BuildContext context) {
    return CandixPage(
      "Line Items",
      // filled: false,
      leading: BackButton(),
      body: PageView(
        children: [
          for (LineItem l in J.pr.current.value!.lineItems!) _LineItemView(l)
        ],
      ),
    );
  }
}

class _LineItemView extends StatelessWidget {
  final LineItem item;

  _LineItemView(this.item);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          children: [
            Space.Y(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Builder(builder: (context) {
                        String status = item.status!.toString().split(".").last;
                        return Text(
                          status,
                          style: TextStyle(
                              color: status == "pending"
                                  ? Colors.amber.shade700
                                  : status == "declined"
                                      ? Colors.red
                                      : Colors.green,
                              fontWeight: FontWeight.bold),
                        );
                      })
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                (item.qty ?? 1).format,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Qty",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          Space.X(15),
                          Text("x"),
                          Space.X(15),
                          Column(
                            children: [
                              Text(
                                "₦" + (item.price ?? 0).format,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Price",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          Space.X(15),
                          Text("="),
                          Space.X(15),
                          Column(
                            children: [
                              Text(
                                "₦" + item.amount.format,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Total",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(),
                  Space.Y(10),
                  Text(item.description!),
                ],
              ),
            ),
            Divider(),
            if (item.image != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: .3.ofHeight,
                    color: mild,
                    child: CachedNetworkImage(
                      imageUrl: item.image!,
                      fit: BoxFit.cover,
                      placeholder: (context, _) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
        Container(
          height: 25,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.black45,
            // borderRadius: BorderRadius.only(
            //     bottomRight: Radius.circular(12),
            //     bottomLeft: Radius.circular(12))
          ),
          child: Center(
              child: Text(
            "${J.pr.current.value!.lineItems!.indexOf(item) + 1} / ${J.pr.current.value!.lineItems!.length}",
            style: TextStyle(color: Colors.white),
          )),
        )
      ],
    );
  }
}
