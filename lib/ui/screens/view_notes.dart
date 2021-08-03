import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/note.dart';
import 'package:candix/ui/crumbs/page.dart';
import 'package:flutter/material.dart';

class AllNotes extends StatelessWidget {
  static final String uri = "/notes/all";

  @override
  Widget build(BuildContext context) {
    return CandixPage(
      "Notes",
      leading: BackButton(),
      body: ListView(
        padding: EdgeInsets.only(),
        children: [
          for (Note n in J.pr.notes)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                tileColor: Colors.white,
                title: Text(n.message!),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(n.actor?.name ?? ""),
                    // Text(
                    //   n.type ?? "",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: n.type == "approved"
                    //           ? Colors.green
                    //           : n.type == "rejected"
                    //               ? Colors.red
                    //               : Colors.amber),
                    // )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
