import 'package:candix/core/models/user.dart';

class Note {
  int? procurementID;
  String? message;
  String? type;
  User? actor;

  Note.form(Map<String, Object?> json)
      : procurementID = json["procurement_id"] as int?,
        message = json['body'] as String?,
        type = json['type'] as String?,
        actor = User.form(json['staff'] as Map<String, dynamic>);

  Map<String, dynamic> get json {
    return {
      "procurement_id": procurementID,
      "body": message?.trim().isEmpty ?? true ? "No message" : message,
      "type": type
    };
  }

  static List<Note> many(List<Map<String, Object?>> list) =>
      list.map((e) => Note.form(e)).toList();

  Note();
}
