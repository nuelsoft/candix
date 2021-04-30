import 'dart:math';

import 'package:candix/core/models/line_item.dart';
import 'package:candix/core/models/user.dart';
import 'package:intl/intl.dart';

class ProcurementRequest {
  int? id;
  String? uid;
  String? title;
  String? description;
  PRStatus? status;
  PRPriority? priority;
  List<String>? images;
  List<LineItem>? lineItems;
  int? department;
  User? staff;
  DateTime? createdAt;
  DateTime? approvedAt;

  static PRStatus _status(String s) {
    switch (s) {
      case "pending":
        return PRStatus.pending;
      case "approved":
        return PRStatus.approved;
      case "rejected":
        return PRStatus.rejected;
      default:
        throw "Unknown status";
    }
  }

  static PRPriority _priority(String s) {
    switch (s) {
      case "high":
        return PRPriority.high;
      case "medium":
        return PRPriority.medium;
      case "low":
        return PRPriority.low;
      default:
        throw "Unknown status";
    }
  }

  String get date {
    final DateFormat f = DateFormat('Md');
    return f.format(createdAt!);
  }

  String get longDate {
    final DateFormat f = DateFormat('yMMMMd');
    return f.format(createdAt!);
  }

  String get time {
    final DateFormat f = DateFormat('jm');
    return f.format(createdAt!);
  }

  ProcurementRequest();

  ProcurementRequest.form(Map<String, Object?> json)
      : id = json["id"] as int,
        uid = json["uid"] as String?,
        title = json["title"] as String,
        description = json["description"] as String,
        status = _status(json["status"] as String? ?? "pending"),
        priority = _priority(json["priority"] as String),
        lineItems = json["line_items"] == null
            ? []
            : LineItem.formMultiple(List<Map<String, dynamic>>.from(
                json["line_items"] as Iterable<dynamic>)),
        staff = User.form(json["staff"] as Map<String, Object?>? ??
            {"id": int.parse(json["staff_id"].toString())}),
        department = json["department_id"] as int,
        createdAt = DateTime.parse(json["created_at"] as String),
        approvedAt = json["approved_at"] == null
            ? null
            : DateTime.parse(json["approved_at"] as String);

  int get descLength => min(255, description?.length ?? 0);

  String? get truncatedDescription {
    bool gtMax = (description?.length ?? 0) > 255;

    return '${description?.substring(0, gtMax ? 255 : description?.length)}'
        ' ${gtMax ? '...' : ''}';
  }

  Map<String, Object?> get json => {
        "title": title,
        "description": description,
        "priority": priority!.val,
        "images": images,
        "line_items": lineItems!.map((e) => e.json).toList()
      };

  static List<ProcurementRequest> many(List<Map<String, Object?>> l) =>
      l.map((e) => ProcurementRequest.form(e)).toList();
}

enum PRStatus { pending, approved, rejected }
enum PRPriority { low, medium, high }

extension prStatus on PRStatus {
  String get val {
    String tr = this.toString().split(".")[1];
    return tr[0].toUpperCase() + tr.substring(1, tr.length);
  }
}

extension prPriority on PRPriority {
  String get val {
    return this.toString().split(".")[1];
  }
}
