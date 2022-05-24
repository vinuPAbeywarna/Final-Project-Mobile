class CategoryModel {
  final String id;
  final String category_name;
  final String image;

  CategoryModel(
      {required this.id, required this.category_name, required this.image});

  Map<String, dynamic> toMap() =>
      {"id": this.id, "Category_name": this.category_name, "image": this.image};

  CategoryModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"].toString(),
        category_name = map["Category_name"] ?? " ",
        image = map["image"] ?? " ";
}
