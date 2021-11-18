import 'dart:convert';
import 'package:old_change_app/models/product_real.dart';
import 'package:http/http.dart' as http;

abstract class ProductListReponsitory {
  Future<List<Product>> fetchProduct(String input);
}

class ProductListReponsitoryIml implements ProductListReponsitory {
  List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  @override
  Future<List<Product>> fetchProduct(String input) async {
    String url =
        'https://old-stuff-exchange-api.herokuapp.com/api/categories/' + input;
    return await http.get(Uri.parse(url)).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
      if (statusCode != 200 || jsonBody == null) {
        // print(response.reasonPhrase);
        throw new Exception("Lỗi load api");
      }
      // final JsonDecoder _decoder = new JsonDecoder();
      // final productListContainer = _decoder.convert(jsonBody);
      // final List productList = productListContainer[''];
      return parseProducts(response.body);
    });
  }
}
