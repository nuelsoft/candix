import 'package:cached_network_image/cached_network_image.dart';
import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/line_item.dart';
import 'package:candix/ui/crumbs/_get_image.dart';
import 'package:candix/ui/crumbs/button.dart';
import 'package:candix/ui/crumbs/input.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

class LineItemr extends StatefulWidget {
  static final String uri = "requestr/line_itemr";
  static final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final Function(LineItem)? onFinish;

  LineItemr({this.onFinish});

  @override
  _LineItemrState createState() => _LineItemrState();
}

class _LineItemrState extends State<LineItemr> {
  @override
  Widget build(BuildContext context) {
    return CandixPage(
      "Add Line Item",
      leading: BackButton(),
      filled: false,
      body: Form(
        key: LineItemr._form,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Space.Y(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => CollectImage((i) {
                              if (i != null) {
                                J.li.image.value = i;
                              }
                            }),
                        backgroundColor: Colors.transparent);
                  },
                  child: Obx(() => Container(
                        height: .20.ofHeight,
                        decoration: BoxDecoration(color: mild),
                        child: J.li.image.value != null
                            ? Image.file(J.li.image.value!, fit: BoxFit.cover)
                            : J.li.url.value != null
                                ? Hero(
                                    tag: J.li.url.value!,
                                    child: CachedNetworkImage(
                                      imageUrl: J.li.url.value!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, _) => Center(
                                          child: Icon(PhosphorIcons.package)),
                                    ),
                                  )
                                : Center(
                                    child: Icon(PhosphorIcons.camera_bold,
                                        size: 30, color: primary),
                                  ),
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Space.X(10),
                  Icon(
                    Icons.info,
                    size: 20,
                    color: Colors.grey,
                  ),
                  Space.X(4),
                  Text("Image selection is not compulsory")
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Space.Y(10),
                  Input(
                    'Item',
                    controller: J.li.title,
                    capitalization: TextCapitalization.words,
                    validator: (v) =>
                        v!.trim().isEmpty ? "Please enter title" : null,
                  ),
                  Space.Y(20),
                  Input.multi(
                    "Description (optional)",
                    capitalization: TextCapitalization.sentences,
                    controller: J.li.desc,
                    // validator: (v) => v!.trim().isEmpty
                    //     ? "Please enter request description"
                    //     : null,
                    type: InputType.multiLine,
                    action: TextInputAction.newline,
                  ),
                  Space.Y(20),
                  Row(
                    children: [
                      Expanded(
                        child: Input("Quantity",
                            controller: J.li.qty,
                            type: InputType.number,
                            onChanged: (s) {
                              setState(() {});
                            },
                            validator: (v) => !v!.trim().isNumericOnly
                                ? "Please provide quantity"
                                : null),
                      ),
                      Space.X(15),
                      Expanded(
                        child: Input("Price (₦)",
                            controller: J.li.price,
                            type: InputType.number,
                            onChanged: (s) {
                              setState(() {});
                            },
                            // validator: (v) => !v!.trim().isNum
                            //     ? "Please provide price"
                            //     : null
                        ),
                      ),
                    ],
                  ),
                  Space.Y(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("Sub Total: "),
                        Text(
                          "₦${((int.tryParse(J.li.qty.text) ?? 1) * (int.tryParse(J.li.price.text) ?? 0)).format}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Space.Y(50),
                  Obx(() => Press.dark(
                        'Add',
                        loading: J.li.working.value!,
                        onPressed: () {
                          if (LineItemr._form.currentState!.validate())
                            J.li.validate().then((value) {
                              print(value);
                              if (widget.onFinish != null && value != null) {
                                Get.back();
                                widget.onFinish!(value);
                              }
                            });
                        },
                      )),
                  Space.Y(50)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
