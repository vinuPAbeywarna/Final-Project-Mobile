class WishListModel {
  final int id;
  final int userid;
  final int productid;

  WishListModel({
    this.id = 1,
    required this.userid,
    required this.productid,
  });

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "user_id": this.userid,
        "product_id": this.productid,
      };

  WishListModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        userid = map["user_id"],
        productid = map["product_id"];
}
