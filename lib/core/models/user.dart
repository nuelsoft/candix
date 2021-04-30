class User {
  int id;
  String? uuid;
  String? name;
  String? picture;
  int? department;
  String? address;
  String? email;
  bool? verified;

  User.form(Map<String, Object?> json)
      : id = json["id"] as int,
        uuid = json["uuid"] as String?,
        name = json["fullname"] as String?,
        picture = json["profile_picture"] as String?,
        department = json["department_id"] as int?,
        address = json["address"] as String?,
        email = json["email"] as String?,
        verified = json["email_verified_at"] != null;
}
