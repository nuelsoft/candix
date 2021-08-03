import 'package:cached_network_image/cached_network_image.dart';
import 'package:candix/core/controllers/j.dart';
import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.only(bottom: 40),
        children: [
          Container(
            height: .4.ofHeight,
            color: mild,
            child: Stack(children: [
              J.auth.currentUser!.value!.picture == null
                  ? Center(
                      child: Icon(
                        PhosphorIcons.user,
                        size: 50,
                        color: primary,
                      ),
                    )
                  : Center(
                    child: CachedNetworkImage(
                      height: .4.ofHeight,
                        width: double.infinity,
                        imageUrl: J.auth.currentUser!.value!.picture!,
                        fit: BoxFit.cover,
                        placeholder: (context, _) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                  ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(16),
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(.8)
                        ]),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        J.auth.currentUser!.value!.name!,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Text(
                        J.me!.roleString,
                        style: TextStyle(color: Colors.grey[300]),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
          Space.Y(10),
          ListTile(
            title: Text("Edit profile"),
            leading: Icon(PhosphorIcons.pencil_circle),
            onTap: () {},
          ),
          ListTile(
            title: Text("Change Password"),
            leading: Icon(PhosphorIcons.lock),
            onTap: () {},
          ),
          Space.Y(10),
          Divider(),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            leading: Icon(
              PhosphorIcons.sign_out,
              color: Colors.red,
            ),
            onTap: () {},
          ),
          Space.Y(.1.ofHeight),
          Space.Y(40),
          Column(children: [
            Text(
              "${DateTime.now().year} CANDIX",
              style: TextStyle(color: Colors.grey[700]),
            ),
            Text(
              "Version 0.0.1",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            )
          ])
        ],
      ),
    );
  }
}
