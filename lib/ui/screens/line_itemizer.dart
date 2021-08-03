import 'package:cached_network_image/cached_network_image.dart';
import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/line_item.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:candix/ui/screens/line_itemr.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

class LineItemizer extends StatelessWidget {
  static final String uri = "requestr/line_itemizer";

  @override
  Widget build(BuildContext context) {
    return CandixPage(
      "Line Items",
      filled: false,
      leading: BackButton(),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.zero,
          children: [
            for (Rx<LineItem> item in J.pr.lineItems)
              ListTile(
                title: Text(item.value!.title!),
                subtitle: item.value!.description?.trim().isEmpty ?? true
                    ? null
                    : Text(item.value!.description!),
                trailing: IconButton(
                  icon: Icon(PhosphorIcons.trash),
                  onPressed: () {
                    J.pr.lineItems.remove(item);
                  },
                ),
                onTap: () {
                  J.li.reset(item.value);
                  Get.to(() => LineItemr(onFinish: (v) {
                        item.value = v;
                      }));
                },
                leading: item.value!.image == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(color: Colors.grey),
                          child: Center(child: Icon(PhosphorIcons.package)),
                        ),
                      )
                    : Hero(
                        tag: item.value!.image!,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CachedNetworkImage(
                              imageUrl: item.value!.image!,
                              placeholder: (context, _) => Center(
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: Center(
                                      child: Icon(PhosphorIcons.package)),
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
              ),
            if (J.pr.lineItems.isNotEmpty) ...[Space.Y(20), Divider()],
            ListTile(
              title: Text("Add Line item"),
              leading: Icon(PhosphorIcons.plus_circle_fill),
              onTap: () {
                J.li.reset();
                Get.to(() => LineItemr(onFinish: (v) {
                      J.pr.lineItems.add(v.obs);
                    }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
