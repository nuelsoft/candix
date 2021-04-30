import 'package:candix/core/controllers/j.dart';
import 'package:candix/ui/screens/account.dart';
import 'package:candix/ui/screens/overview.dart';
import 'package:candix/ui/screens/requests.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Home extends StatelessWidget {
  static final String uri = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => [
          Account(),
          Overview(),
          Requests()
        ][J.global.currentHomeIndex.value],
      ),
      backgroundColor: milder,
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: J.global.currentHomeIndex.value,
            onTap: (i) {
              J.global.currentHomeIndex.value = i;
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(PhosphorIcons.user), label: "Account"),
              BottomNavigationBarItem(
                  icon: Icon(PhosphorIcons.house_simple),
                  activeIcon: Icon(PhosphorIcons.house_simple_fill),
                  label: "Overview"),
              BottomNavigationBarItem(
                  icon: Icon(PhosphorIcons.git_pull_request),
                  activeIcon: Icon(PhosphorIcons.git_pull_request_fill),
                  label: "Request")
            ],
          )),
    );
  }
}
