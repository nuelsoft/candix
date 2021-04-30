import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';

class BackDrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          width: double.infinity,
          height: 1.0.ofHeight,
          child: Image.asset(
            "assets/cover.bg.png",
            fit: BoxFit.cover,
            color: Theme.of(context).primaryColor,
            colorBlendMode: BlendMode.darken,
          ),
        ),
      ],
    );
  }
}
