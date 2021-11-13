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
    // Response reponse;
    try {
      String url = 'https://old-stuff-exchange-api.herokuapp.com/api/order';
      dio.options.headers["authorization"] = "Bearer " + token.toString();
      final response = await dio.post(
        url,
        data: cartRequest.toJson(),
      );
      if (response.statusCode == 200) {
        return Result.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        return Result.fromJson(e.response.data);
      } else if (e.response.statusCode == 401) {
        throw Exception("wrong token");
      } else {
        // print(reponse.statusCode);
        throw Exception("check out error");
      }
    }
  }
}
