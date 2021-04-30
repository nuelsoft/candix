import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CandixPage extends StatelessWidget {
  final Widget? body;
  final Widget? leading;
  final Widget? trailing;
  final String title;
  final bool filled;

  CandixPage(this.title, {this.leading, this.filled = true, this.trailing, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: filled? milder: Colors.white,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (leading != null) ...[leading!, Space.X(10)],
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
