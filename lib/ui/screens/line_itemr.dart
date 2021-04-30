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

class LineItemr extends StatelessWidget {
  static final String uri = "requestr/line_itemr";
  static final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final Function(LineItem)? onFinish;

  LineItemr({this.onFinish});

  @override
  Widget build(BuildContext context) {
    return CandixPage(
      "Add Line Item",
      leading: BackButton(),
      filled: false,
      body: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Space.Y(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
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
                        height: .3.ofHeight,
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Space.Y(30),
                  Input(
                    'Title',
                    controller: J.li.title,
                    capitalization: TextCapitalization.words,
                    validator: (v) =>
                        v!.trim().isEmpty ? "Please enter title" : null,
                  ),
                  Space.Y(20),
                  Input.multi(
                    "Description",
                    capitalization: TextCapitalization.sentences,
                    controller: J.li.desc,
                    validator: (v) => v!.trim().isEmpty
                        ? "Please enter request description"
                        : null,
                    type: InputType.multiLine,
                    action: TextInputAction.newline,
                  ),
                  Space.Y(50),
                  Obx(() => Press.dark(
                        'Add',
                        loading: J.li.working.value!,
                        onPressed: () {
                          if (_form.currentState!.validate())
                            J.li.validate().then((value) {
                              if (onFinish != null && value != null) {
                                Get.back();
                                onFinish!(value);
                              }
                            });
                        },
                      )),
                  Space.Y(30)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
