import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'backdrop.dart';

class AuthPortal extends StatelessWidget {
  final String title;
  final Widget? body;
  final bool back;

  AuthPortal(this.title, {this.body, this.back = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackDrop(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Space.Y(30),
                      Text(
                        "Staff Portal",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Space.Y(15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Divider(color: Colors.white54),
                      ),
                      Space.Y(5),
                      Text(
                        "$title",
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  )),
              Space.Y(20),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: body))
            ],
          ),
          if (back)
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 4),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ))
        ],
      ),
    );
  }
}
