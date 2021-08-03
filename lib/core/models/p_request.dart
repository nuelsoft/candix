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
  User? approvedBy;
  User? rejectedBy;
  User? reviewedBy;
  DateTime? createdAt;
  DateTime? approvedAt;

  String? rejectionMessage;

  static PRStatus statusFormator(String s) {
    switch (s) {
      case 'sent':
        return PRStatus.sent;
      case "pending":
        return PRStatus.pending;
      case 'reviewed':
        return PRStatus.reviewed;
      case "approved":
        return PRStatus.approved;
      case "rejected":
        return PRStatus.rejected;
      case "processed":
        return PRStatus.processed;
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

  bool get isReviewed =>
      status == PRStatus.reviewed ||
      status == PRStatus.approved ||
      status == PRStatus.rejected ||
      status == PRStatus.processed;

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
        status = statusFormator(json["status"] as String? ?? "pending"),
        priority = _priority(json["priority"] as String),
        lineItems = json["line_items"] == null
            ? []
            : LineItem.formMultiple(List<Map<String, dynamic>>.from(
                json["line_items"] as Iterable<dynamic>)),
        staff = User.form(json["staff"] as Map<String, Object?>? ??
            {"id": int.parse(json["staff_id"].toString())}),
        approvedBy = json['approved_by'] == null
            ? null
            : User.form(json["approved_by"] as Map<String, Object?>? ??
                {"id": int.parse(json["approved_by"].toString())}),
        rejectedBy = json['rejected_by'] == null
            ? null
            : User.form(json["rejected_by"] as Map<String, Object?>? ??
                {"id": int.parse(json["rejected_by"].toString())}),
        rejectionMessage = json['rejection_note'] as String?,
        reviewedBy = json['reviewed_by'] == null
            ? null
            : User.form(json["reviewed_by"] as Map<String, Object?>? ??
                {"id": int.parse(json["reviewed_by"].toString())}),
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

  Map<String, Object?> get json {
    Map<String, Object?> o = {
      "title": title,
      "description": description,
      "priority": priority!.val,
      // "images": ["asdf"],
      "line_items": lineItems!.map((e) => e.json).toList(),
    };

    return o;
  }

  Map<String, Object?> get statusData {
    Map<String, Object?> o = {
      "status": status?.data,
    };
    print(o);
    return o;
  }

  static List<ProcurementRequest> many(List<Map<String, Object?>> l) =>
      l.map((e) => ProcurementRequest.form(e)).toList();

  double get totalAmount {
    double amt = 0;
    for (LineItem l in lineItems ?? []) amt += l.amount;
    return amt;
  }
}

enum PRStatus { sent, pending, reviewed, approved, rejected, processed }
enum PRPriority { low, medium, high }

extension prStatus on PRStatus {
  String get val {
    String tr = this.toString().split(".")[1];
    return tr[0].toUpperCase() + tr.substring(1, tr.length);
  }

  String get data {
    return this.toString().split(".")[1];
  }
}

extension prPriority on PRPriority {
  String get val {
    return this.toString().split(".")[1];
  }
}
