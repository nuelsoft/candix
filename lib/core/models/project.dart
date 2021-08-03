class Project {
  int? id;
  String? name;
  int? procurements;

  Project.form(Map<String, Object?> json)
      : id = json["id"] as int,
        name = json["name"] as String,
        procurements = (json["procurements"] as Iterable? ?? []).length;

  static List<Project> many(List<Map<String, Object?>> list) =>
      list.map((e) => Project.form(e)).toList();
}
