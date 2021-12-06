import 'dart:convert';

import 'package:old_change_app/models/input/cicle_one.dart';
import 'package:http/http.dart' as http;

abstract class CircleOneRepository {
  Future<List<CircleOne>> getOne(int id);
}

class CircleOneRepositoryIml implements CircleOneRepository {
  List<CircleOne> parseCategories(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<CircleOne>((json) => CircleOne.fromJson(json)).toList();
  }

  @override
  Future<List<CircleOne>> getOne(int id) async {
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/suggestMapping/listSuggestForProduct/$id";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return parseCategories(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
