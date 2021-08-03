class User {
  int id;
  String? uuid;
  String? name;
  String? picture;
  int? department;
  String? address;
  String? email;
  bool? verified;
  List<Map<String, dynamic>>? roles;

  User.form(Map<String, Object?> json)
      : id = json["id"] as int,
        uuid = json["uuid"] as String?,
        name = json["fullname"] as String?,
        picture = json["profile_picture"] as String?,
        department = json["department_id"] as int?,
        address = json["address"] as String?,
        email = json["email"] as String?,
        roles =
            List<Map<String, dynamic>>.from((json["roles"] ?? []) as Iterable),
        verified = json["email_verified_at"] != null;

  Role get role {
    String anchor = roles?.first['name'] ?? 'field agent';
    if (anchor.contains('hod')) return Role.hod;
    if (anchor.contains('supervisor')) return Role.supervisor;
    return Role.field_agent;
  }

  bool get isHOD => role == Role.hod;
  bool get isSupervisor => role == Role.supervisor;
  bool get isFieldAgent => role == Role.field_agent;

  String get roleString {
    Role r = role;
    if (r == Role.supervisor) return 'Supervisor';
    if (r == Role.hod) return 'HOD';
    return 'Field Agent';
  }
}

enum Role { hod, supervisor, field_agent }
