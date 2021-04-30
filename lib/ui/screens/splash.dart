import 'package:candix/ui/crumbs/backdrop.dart';
import 'package:candix/ui/crumbs/button.dart';
import 'package:candix/ui/screens/login.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatelessWidget {
  static final String uri = "/splash";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 1.0.ofHeight,
            width: 1.0.ofWidth,
            color: primary,
            child: BackDrop(),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Staff",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                  ),
                  Space.Y(30),
                  Text(
                    "Candix Engineering Nigeria Limited",
                    style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Space.Y(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Divider(color: Colors.white54),
                  ),
                  Space.Y(5),
                  Text(
                    "Enterprise Resource Planning",
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.poppins(fontSize: 20, color: Colors.white70),
                  ),
                  Space.Y(70),
                  Press.light(
                    "Continue",
                    onPressed: () {
                      Get.toNamed(Login.uri);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
