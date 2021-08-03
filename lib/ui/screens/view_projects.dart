import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/project.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProjects extends StatelessWidget {
  static final String uri = "projects/all";

  @override
  Widget build(BuildContext context) {
    return CandixPage(
      "All Projects",
      leading: BackButton(),
      filled: false,
      body: J.pr.projects.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                "No Projects detected. Please review with admin",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
            ),
              ))
          : ListView(
        padding: EdgeInsets.zero,
              children: [
                for (Project p in J.pr.projects)
                  Column(
                    children: [
                      ListTile(
                        title: Text(p.name!),
                        onTap: () {
                          J.pr.selectedProject.value = p;
                          Get.back();
                        },
                      ),
                      Divider()
                    ],
                  )
              ],
            ),
    );
  }
}
