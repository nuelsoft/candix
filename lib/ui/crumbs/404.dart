import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class NotFound extends StatelessWidget {
  final String? text;

  NotFound([this.text]);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(PhosphorIcons.placeholder, size: 50),
          Space.Y(10),
          Text(text ?? "Not found")
        ],
      ),
    );
  }
}
