import 'package:old_change_app/models/cart_request.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class CheckOutRepository {
  Future<Result> checkOut(String token, CartRequest cartRequest);
}

class CheckOutRepositoryIml implements CheckOutRepository {
  @override
  Future<Result> checkOut(String token, CartRequest cartRequest) async {
    String url = "https://old-stuff-exchange-api.herokuapp.com/api/order";
    Map<String, String> header = {'Authorization': 'Bearer ' + token};
    final reponse = await http.post(Uri.parse(url),
        body: cartRequest.toJson(), headers: header);
    if (reponse.statusCode == 200) {
      return Result.fromJson(json.decode(reponse.body));
    } else if (reponse.statusCode == 404) {
      return Result.fromJson(json.decode(reponse.body));
    } else {
      throw Exception("Loi check out");
    }
  }
}
