import 'package:vinsartisanmarket/models/productModel.dart';

class FetchCartModel {
  final int id;
  final int userid;
  final int productid;
  final int qty;
  final String createdat;
  final String updatedat;
  final Productmodel product;

  FetchCartModel(
      {required this.id,
      required this.userid,
      required this.productid,
      required this.qty,
      required this.createdat,
      required this.updatedat,
      required this.product});

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "user_id": this.userid,
        "product_id": this.productid,
        "qty": this.qty,
        "created_at": this.createdat,
        "updated_at": this.updatedat,
        "product": this.product.toMap()
      };

  FetchCartModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        userid = map["user_id"],
        productid = map["product_id"],
        qty = map["qty"],
        updatedat = map["updated_at"],
        createdat = map["created_at"],
        product = Productmodel.fromMap(map["product"]);
}
