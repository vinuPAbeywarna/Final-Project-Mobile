class OrderModel {
  final int id;
  final String address;
  final String full_name;
  final double total;
  final String city;
  final String state;
  final String payment_type;
  final String postal_code;
  final String order_note;
  final int user_id;
  final String contact_no;
  final int is_paid;

  OrderModel(
      {this.id = 1,
      required this.address,
      required this.full_name,
      required this.total,
      required this.city,
      required this.state,
      required this.payment_type,
      required this.postal_code,
      required this.order_note,
      required this.user_id,
      required this.contact_no,
      this.is_paid = 0});

  Map<String, dynamic> toMap() => {
        // "id": this.id,
        "address": this.address,
        "full_name": this.full_name,
        "total": this.total,
        "city": this.city,
        "state": this.state,
        "payment_type": this.payment_type,
        "postal_code": this.postal_code,
        "order_note": this.order_note,
        "user_id": this.user_id,
        "contact_no": this.contact_no,
        // "is_paid": is_paid
      };

  OrderModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        address = map["address"].toString(),
        full_name = map["full_name"] as String,
        total = map["total"].toDouble(),
        city = map["city"] as String,
        state = map["state"].toString(),
        payment_type = map["payment_type"],
        postal_code = map["postal_code"],
        user_id = map["user_id"],
        order_note = map["order_note"] ?? "",
        contact_no = map["contact_no"],
        is_paid = map["is_paid"] ?? 0;
}
