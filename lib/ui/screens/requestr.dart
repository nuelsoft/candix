import 'package:cached_network_image/cached_network_image.dart';
import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/p_request.dart';
import 'package:candix/core/services/functions.dart';
import 'package:candix/ui/crumbs/_get_image.dart';
import 'package:candix/ui/crumbs/button.dart';
import 'package:candix/ui/crumbs/input.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import 'line_itemizer.dart';

class Requestr extends StatelessWidget {
  static final String uri = "/requestr";
  static final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CandixPage(
      '${J.pr.current.value == null ? "New" : "Edit"} Request',
      leading: BackButton(),
      filled: false,
      body: Form(
          key: _form,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Space.Y(20),
                    Input(
                      'Title',
                      controller: J.pr.title,
                      capitalization: TextCapitalization.words,
                      validator: (v) =>
                          v!.trim().isEmpty ? "Please enter title" : null,
                    ),
                    Space.Y(20),
                    Input.multi(
                      "Description",
                      capitalization: TextCapitalization.sentences,
                      controller: J.pr.desc,
                      validator: (v) => v!.trim().isEmpty
                          ? "Please enter request description"
                          : null,
                      type: InputType.multiLine,
                      action: TextInputAction.newline,
                    ),
                    Space.Y(20),
                    Text(
                      "Urgency",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Please select urgency of this request",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Space.Y(16),
                    Obx(() => Wrap(children: [
                          for (Map<String, Object?> u in [
                            {
                              "label": "Low",
                              "value": PRPriority.low,
                              "icon": PhosphorIcons.warning_thin
                            },
                            {
                              "label": "Medium",
                              "value": PRPriority.medium,
                              "icon": PhosphorIcons.warning
                            },
                            {
                              "label": "High",
                              "value": PRPriority.high,
                              "icon": PhosphorIcons.warning_fill
                            }
                          ])
                            GestureDetector(
                              onTap: () {
                                J.pr.urgency!.value = u["value"] as PRPriority;
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                margin: EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                    color: u["value"] == J.pr.urgency!.value
                                        ? primary.withOpacity(.2)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(u["icon"] as IconData),
                                    Space.X(10),
                                    Text(u["label"] as String)
                                  ],
                                ),
                              ),
                            ),
                        ])),
                    Space.Y(20),
                    Divider()
                  ],
                ),
              ),

              Obx(() => ListTile(
                title: Text("Manage Line Items"),
                leading: Icon(PhosphorIcons.list_bullets_bold),
                subtitle: Text("${J.pr.lineItems.length} item${J.pr.lineItems.length != 1? "s" : ""} added"),
                onTap: () => Get.toNamed(LineItemizer.uri),
              )),
              Space.Y(50),
              Obx(() => Press.dark(
                    'Submit',
                    loading: J.pr.saving.value!,
                    onPressed: () {
                      if (_form.currentState!.validate()) {
                        J.pr.submitRequest();
                      }
                    },
                  )),
              Space.Y(30)
            ],
          )),
    );
  }
}
