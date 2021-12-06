import 'dart:convert';

import 'package:old_change_app/models/input/cicle_screen1.dart';
import 'package:http/http.dart' as http;

abstract class CircleHomeRepository {
  Future<List<CircleHome>> getCircleHome(String token);
}

class CircleHomeRepositoryIml implements CircleHomeRepository {
  List<CircleHome> parseCategories(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<CircleHome>((json) => CircleHome.fromJson(json)).toList();
  }

  @override
  Future<List<CircleHome>> getCircleHome(String token) async {
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/suggestMapping/listProductSuggest";
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        return parseCategories(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
