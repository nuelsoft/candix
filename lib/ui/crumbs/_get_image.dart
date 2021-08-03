import 'dart:io';

import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CollectImage extends StatelessWidget {
  final Function(File? image) onSelect;

  CollectImage(this.onSelect);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Select Image",
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Space.Y(10),
          ListTile(
            title: Text("Camera"),
            leading: Icon(PhosphorIcons.camera),
            onTap: () async {
              Get.back();
              PickedFile? f =
                  await ImagePicker().getImage(source: ImageSource.camera);
              if (f != null) onSelect(File(f.path));
            },
          ),
          ListTile(
            title: Text("Gallery"),
            leading: Icon(PhosphorIcons.image),
            onTap: () async {
              Get.back();
              PickedFile? f =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              if (f != null) onSelect(File(f.path));
            },
          )
        ],
      ),
    );
  }
}
