import 'package:candix/core/controllers/j.dart';
import 'package:candix/ui/screens/forgot_password.dart';
import 'package:candix/ui/screens/home.dart';
import 'package:candix/ui/screens/line_itemizer.dart';
import 'package:candix/ui/screens/line_itemr.dart';
import 'package:candix/ui/screens/login.dart';
import 'package:candix/ui/screens/no_roles.dart';
import 'package:candix/ui/screens/pr_accept.dart';
import 'package:candix/ui/screens/pr_line_items.dart';
import 'package:candix/ui/screens/pr_reject.dart';
import 'package:candix/ui/screens/request_view.dart';
import 'package:candix/ui/screens/requestr.dart';
import 'package:candix/ui/screens/splash.dart';
import 'package:candix/ui/screens/view_notes.dart';
import 'package:candix/ui/screens/view_projects.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  J.register();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Candix Staff',
      theme: ThemeData(
          primaryColor: primary,
          accentColor: primary,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: Splash(),
      routes: {
        Splash.uri: (context) => Splash(),
        Login.uri: (context) => Login(),
        ForgotPassword.uri: (context) => ForgotPassword(),
        Home.uri: (context) => Home(),
        Requestr.uri: (context) => Requestr(),
        RequestView.uri: (context) => RequestView(),
        LineItemizer.uri: (context) => LineItemizer(),
        LineItemr.uri: (context) => LineItemr(),
        ProcurementRequestLineItems.uri: (context) => ProcurementRequestLineItems(),
        YouHaveNoRoles.uri: (context) => YouHaveNoRoles(),
        RejectionScreen.uri: (context) => RejectionScreen(),
        AcceptPR.uri: (context) => AcceptPR(),
        AllProjects.uri: (context) => AllProjects(),
        AllNotes.uri: (context) => AllNotes()
      },
    );
  }
}
