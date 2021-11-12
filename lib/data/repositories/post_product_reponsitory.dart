import 'package:dio/dio.dart';
import 'package:old_change_app/models/input/post_product_result.dart';
import 'package:old_change_app/models/input/product_form.dart';

abstract class PostProductRepository {
  Future<PostProductResult> postProduct(ProductPost product);
}

class PostProductRepositoryIml implements PostProductRepository {
  @override
  Future<PostProductResult> postProduct(ProductPost product) async {
    String url = "https://old-stuff-exchange-api.herokuapp.com/api/products/";
    var dio = Dio();
    final reponse = await dio.post(url, data: product.toJson());
    if (reponse.statusCode == 200) {
      return PostProductResult.fromJson(reponse.data);
    } else {
      throw Exception("Fail Post Product");
    }
  }
}
