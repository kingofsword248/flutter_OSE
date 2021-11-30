import 'dart:io';

import 'package:dio/dio.dart';

abstract class AcceptExchangeReuqestRepository {
  Future<bool> acceptExchangeRequest(int idRequest, String token);
}

class AcceptExchangeReuqestRepositoryIml
    implements AcceptExchangeReuqestRepository {
  @override
  Future<bool> acceptExchangeRequest(int idRequest, String token) async {
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/exchange/acceptChange";

    Map data = {"idRequest": idRequest};
    var dio = Dio();
    dio.options.headers["Authorization"] = "Bearer " + token.toString();
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.statusMessage);
        return false;
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
