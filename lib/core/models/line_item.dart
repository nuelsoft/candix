import 'p_request.dart';

class LineItem {
  int? id;
  String? title;
  String? description;
  String? image;
  double? price;
  int? qty;

  PRStatus? status;

  LineItem.form(Map<String, dynamic> json)
      : title = json["title"],
        description = json["description"],
        id = json["id"],
        image = json["image"],
        qty = json["qty"],
        price = double.tryParse((json["price"]?? "0").toString()),
        status = ProcurementRequest.statusFormator(json["status"]);

  LineItem();

  get json => {
        "title": title,
        "description": description,
        "image": image,
        "qty": qty,
        "price": price.toString()
      }..addAll(id == null ? {} : {"id": id.toString()});

  double get amount => (price ?? 0) * (qty ?? 1);

  static List<LineItem> formMultiple(List<Map<String, dynamic>> list) =>
      list.map((e) => LineItem.form(e)).toList();
}
