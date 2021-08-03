import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Press extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color background;
  final Color foreground;
  final bool loading;
  final bool text;

  Press.light(this.title, {this.onPressed, this.loading = false})
      : background = Colors.white,
        text = false,
        foreground = primary;

  Press.dark(this.title, {this.onPressed, this.loading = false})
      : background = primary,
        text = false,
        foreground = Colors.white;

  Press.mild(this.title, {this.onPressed, this.loading = false})
      : background = mild,
        text = false,
        foreground = Colors.black;

  Press.text(this.title, {this.onPressed, this.loading = false})
      : background = mild,
        text = true,
        foreground = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: .1.ofWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text
              ? TextButton(
                  onPressed: loading ? null :  onPressed,
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(color: foreground),
                  ),
                )
              : Expanded(
                  child: ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: loading
                          ? SizedBox(
                              child: CircularProgressIndicator(),
                              height: 25,
                              width: 25,
                            )
                          : Text(
                              title,
                              style: GoogleFonts.poppins(
                                  color: foreground,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                    onPressed: loading ? null : onPressed,
                    style: ElevatedButton.styleFrom(
                        primary: background,
                        shadowColor: background,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                  ),
                ),
        ],
      ),
    );
  }
}
