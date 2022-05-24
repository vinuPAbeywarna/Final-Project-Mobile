import 'package:vinsartisanmarket/models/categoryModel.dart';

class Productmodel {
  final String id;
  final String owner;
  final String name;
  final double price;
  final String description;
  final String category_id;
  final int approved;
  final String image;
  final String created_at;
  final String updated_at;
  final CategoryModel category;

  Productmodel(
      {required this.id,
      required this.owner,
      required this.name,
      required this.price,
      required this.description,
      required this.category_id,
      required this.approved,
      required this.image,
      required this.created_at,
      required this.updated_at,
      required this.category});

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "owner": this.owner,
        "name": this.name,
        "price": this.price,
        "description": this.description,
        "category_id": this.category_id,
        "approved": this.approved,
        "image": this.image,
        "created_at": this.created_at,
        "updated_at": this.updated_at,
        "category": this.category.toMap()
      };

  Productmodel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"].toString(),
        owner = map["owner"].toString(),
        name = map["name"] as String,
        price = map["price"].toDouble(),
        description = map["description"] as String,
        category_id = map["category_id"].toString(),
        approved = map["approved"] as int,
        image = map["image"],
        updated_at = map["updated_at"],
        created_at = map["created_at"],
        category = CategoryModel.fromMap(map["category"] ?? {});
}
