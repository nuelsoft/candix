import 'package:candix/core/models/user.dart';
import 'package:candix/core/services/_api.dart';
import 'package:candix/core/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Authenticator extends GetxController {
  TextEditingController email = TextEditingController(text: "nuel.mailbox@gmail.com");
  TextEditingController password = TextEditingController(text: "CandixERP1234");

  String? token;

  Rx<User>? currentUser;

  RxBool loading = false.obs;

  Future<void> login() async {
    loading.value = true;
    NetworkResponse r = await UserService().login(email.text, password.text);
    print(r.data);
    if (r.succeed) {
      currentUser = User.form(
              (r.data as Map<String, Object?>)["user"] as Map<String, Object?>)
          .obs;
      token = (r.data as Map<String, Object?>)["token"] as String?;
    }
    loading.value = false;
  }

  Future<void> resetPassword() async {
    loading.value = true;
    // NetworkResponse r = await UserService().login(email.text, password.text);
    loading.value = false;
  }
}
