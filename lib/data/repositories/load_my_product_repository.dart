import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:old_change_app/models/product_real.dart';

abstract class LoadMyProductRepository {
  Future<List<Product>> loadMyProduct(String token);
}

class LoadMyProductRepositoryIml implements LoadMyProductRepository {
  List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  @override
  Future<List<Product>> loadMyProduct(String token) async {
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/users/product";
    String header = "Bearer " + token.toString();
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': header,
      };
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        return parseProducts(response.body);
      } else {
        throw Exception(response.body);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
