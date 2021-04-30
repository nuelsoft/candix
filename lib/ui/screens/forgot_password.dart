import 'package:candix/core/controllers/j.dart';
import 'package:candix/ui/crumbs/_auth.dart';
import 'package:candix/ui/crumbs/button.dart';
import 'package:candix/ui/crumbs/input.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  static final String uri = "/password/reset";

  @override
  Widget build(BuildContext context) {
    return AuthPortal(
      "Password",
      back: true,
      body: ListView(
        children: [
          Space.Y(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Reset Password",
                    style: TextStyle(
                        color: primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Space.Y(5),
                  Text(
                    "Enter email to get a password reset link",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Space.Y(40),
                  Input(
                    "Email",
                    type: InputType.email,
                    controller: J.auth.email,
                  ),
                  Space.Y(60),
                  Obx(() => Press.dark(
                        "Send Link",
                        loading: J.auth.loading.value!,
                        onPressed: () {
                          J.auth.resetPassword();
                        },
                      ))
                ]),
          )
        ],
      ),
    );
  }
}
