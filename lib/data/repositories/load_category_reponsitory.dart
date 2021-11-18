import 'dart:convert';

import 'package:old_change_app/models/category.dart';
import 'package:http/http.dart' as http;

abstract class LoadCategoryRepository {
  Future<List<Category>> loadCategory();
}

class LoadCategoryRepositoryIml implements LoadCategoryRepository {
  List<Category> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  }

  @override
  Future<List<Category>> loadCategory() async {
    String url = "https://old-stuff-exchange-api.herokuapp.com/api/brand";
    final reponse = await http.get(Uri.parse(url));
    if (reponse.statusCode == 200) {
      return parseProducts(reponse.body);
    } else {
      throw Exception("Error");
    }
  }
}
