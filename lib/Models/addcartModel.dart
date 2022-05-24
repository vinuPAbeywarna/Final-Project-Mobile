class CartModel {
  final int id;
  final int userid;
  final int productid;
  final int qty;

  CartModel(
      {this.id = 1,
      required this.userid,
      required this.productid,
      required this.qty});

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "user_id": this.userid,
        "product_id": this.productid,
        "qty": this.qty
      };

  CartModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        userid = map["user_id"],
        productid = map["product_id"],
        qty = map["qty"];
}
