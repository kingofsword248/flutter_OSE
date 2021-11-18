import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:old_change_app/models/product_real.dart';

class RemoteApi {
  static List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  static Future<List<Product>> getCharacterList(int page, int limit) async {
    print(page);
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/products/web/?page=$page&limit=$limit";
    final reponse = await http.get(Uri.parse(url));
    if (reponse.statusCode == 200) {
      return parseProducts(reponse.body);
    } else {
      throw Exception("error");
    }
  }
}
