import 'package:candix/ui/crumbs/page.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YouHaveNoRoles extends StatelessWidget {
  static final String uri = "/no-roles";

  @override
  Widget build(BuildContext context) {
    return CandixPage(
      "",
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space.Y(.2.ofHeight),
                Icon(
                  Icons.not_interested,
                  color: Colors.red,
                  size: 50,
                ),
                Space.Y(10),
                Text("Sorry,\nthere's a Problem",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 30)),
                Text(
                  "This probably sounds weird, but we couldn't find your role at Candix.",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: .06.ofHeight),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Please contact your admin",
                    style: TextStyle(color: Colors.black54),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
