import 'package:candix/core/controllers/j.dart';
import 'package:candix/ui/crumbs/button.dart';
import 'package:candix/ui/crumbs/input.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:candix/ui/screens/view_projects.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils.dart';

class AcceptPR extends StatelessWidget {
  static final String uri = "/pr/accept";

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CandixPage(
        'Approve Request',
        filled: false,
        leading: BackButton(),
        body: J.pr.loadingProjects.value == true
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : ListView(
                padding: EdgeInsets.zero,
                children: [
                  if (J.me!.isHOD) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ListTile(
                        title: Text(J.pr.selectedProject.value == null
                            ? "No Project selected"
                            : J.pr.selectedProject.value!.name!),
                        subtitle: Text("Associated project"),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Get.toNamed(AllProjects.uri);
                        },
                      ),
                    ),
                    Divider(),
                    Space.Y(20),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Add note (optional)"),
                        ),
                        Space.Y(4),
                        Input.multi(
                          'Note',
                          controller: J.pr.note,
                        ),
                        Space.Y(50),
                        Press.dark(
                          'Approve',
                          loading: J.pr.accepting.value!,
                          onPressed: () {
                            if (J.me!.isHOD) if (J.pr.selectedProject.value ==
                                null)
                              return J.error(
                                  "All approved requests must reference a project. "
                                  "Please add a project or contact admin for more info");
                            J.pr.react(true).then((value) {
                              Get.back();
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
