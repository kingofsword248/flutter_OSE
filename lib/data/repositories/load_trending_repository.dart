import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:old_change_app/models/trending.dart';

abstract class LoadTrendingRepository {
  Future<List<Trending>> loadTrend();
}

List<Trending> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Trending>((json) => Trending.fromJson(json)).toList();
}

class LoadTrendingRepositoryIml implements LoadTrendingRepository {
  @override
  Future<List<Trending>> loadTrend() async {
    String uri =
        "https://old-stuff-exchange-api.herokuapp.com/api/products/hotTrend";
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        return parseProducts(response.body);
      } else {
        throw Exception("Error");
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
