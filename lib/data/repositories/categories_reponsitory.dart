import 'dart:convert';

import 'package:old_change_app/models/input/category_request.dart';
import 'package:http/http.dart' as http;

abstract class CategoriesRepository {
  Future<List<CategoryRequest>> fetchCategory();
}

class CategoriesRepositoryIml implements CategoriesRepository {
  // List<CategoryRequest> parseCategories(String responseBody) {
  //   final parsed = json.decode(responseBody);
  //   return parsed
  //       .map<CategoryRequest>((json) => CategoryRequest.fromJson(json))
  //       .toList();
  // }

  @override
  Future<List<CategoryRequest>> fetchCategory() async {
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/categories/category/brand";
    // var dio = Dio();
    final reponse = await http.get(Uri.parse(url));
    print(reponse.statusCode);
    if (reponse.statusCode == 200) {
      final List parsed = json.decode(reponse.body);
      List<CategoryRequest> list =
          parsed.map((value) => CategoryRequest.fromJson(value)).toList();
      return list;
    } else {
      throw Exception("error load category");
    }
  }
}
