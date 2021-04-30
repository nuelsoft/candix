class LineItem {
  String? title;
  String? description;
  String? image;

  LineItem.form(Map<String, dynamic> json)
      : title = json["title"],
        description = json["description"],
        image = json["image"];

  LineItem();

  get json => {
    "title": title,
    "description": description,
    "image": image
  };

  static List<LineItem> formMultiple(List<Map<String, dynamic>> list) =>
      list.map((e) => LineItem.form(e)).toList();
}
