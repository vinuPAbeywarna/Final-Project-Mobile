import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:vinsartisanmarket/test/testmodel.dart';

class TestDataHandeler {
  static Future<List<TestModel>> fetchTestModel() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<TestModel>((json) => TestModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<TestModel> fetchTestModelsingel() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return TestModel(userId: 1, id: 2, title: "title", body: "body");
    } else {
      throw Exception('Failed to load album');
    }
  }
}
