import 'dart:convert';

import 'package:old_change_app/models/input/product_detail.dart';
import 'package:http/http.dart' as http;

abstract class LoadProductDetailRepository {
  Future<ProductDetail> loadDetail(int productID);
}

class LoadProductDetailRepositoryIml implements LoadProductDetailRepository {
  @override
  Future<ProductDetail> loadDetail(int productID) async {
    try {
      String uri =
          "https://old-stuff-exchange-api.herokuapp.com/api/products/$productID";
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        return ProductDetail.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
