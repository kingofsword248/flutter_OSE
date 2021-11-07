import 'package:old_change_app/models/cart_request.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

abstract class CheckOutRepository {
  Future<Result> checkOut(String token, CartRequest cartRequest);
}

class CheckOutRepositoryIml implements CheckOutRepository {
  @override
  Future<Result> checkOut(String token, CartRequest cartRequest) async {
    var dio = Dio();
    print(cartRequest.toJson());
    String url = 'https://old-stuff-exchange-api.herokuapp.com/api/order';
    dio.options.headers["authorization"] = "Bearer " + token.toString();
    final reponse = await dio.post(
      url,
      data: cartRequest.toJson(),
    );
    if (reponse.statusCode == 200) {
      return Result.fromJson(reponse.data);
    } else if (reponse.statusCode == 404) {
      return Result.fromJson(json.decode(reponse.data));
    } else if (reponse.statusCode == 401) {
      throw Exception("wrong token");
    } else {
      print(reponse.statusCode);
      throw Exception("check out error");
    }
  }
}
