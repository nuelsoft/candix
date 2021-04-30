import 'package:candix/core/controllers/j.dart';
import 'package:candix/ui/crumbs/_auth.dart';
import 'package:candix/ui/crumbs/button.dart';
import 'package:candix/ui/crumbs/input.dart';
import 'package:candix/ui/screens/forgot_password.dart';
import 'package:candix/ui/screens/home.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  static final String uri = "/login";
  static final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthPortal(
      "Login",
      body: ListView(
        children: [
          Space.Y(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: form,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                          color: primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Space.Y(5),
                    Text(
                      "Sign in to continue to dashboard",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Space.Y(50),
                    Input(
                      "Email",
                      type: InputType.email,
                      controller: J.auth.email,
                      validator: (v) =>
                          !v!.isEmail ? "Email is poorly formatted" : null,
                    ),
                    Space.Y(30),
                    Input(
                      "Password",
                      type: InputType.password,
                      controller: J.auth.password,
                      validator: (v) => v!.length < 8
                          ? "Password must be at least 8 characters"
                          : null,
                    ),
                    Space.Y(5),
                    Obx(() => Press.text(
                          "Forgot Password",
                          loading: J.auth.loading.value!,
                          onPressed: () {
                            Get.toNamed(ForgotPassword.uri);
                          },
                        )),
                    Space.Y(60),
                    Obx(() => Press.dark(
                          "Login",
                          loading: J.auth.loading.value!,
                          onPressed: () {
                            if (form.currentState?.validate() ?? false)
                              J.auth.login().then((_) {
                                if (J.me != null) {
                                  J.pr.fetchRequests();
                                  Get.toNamed(Home.uri);
                                }
                              });
                          },
                        ))
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
