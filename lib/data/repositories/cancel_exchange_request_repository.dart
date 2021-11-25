import 'package:dio/dio.dart';

abstract class CancelExchangeRepositpry {
  Future<bool> cancelExchange(int orderID);
}

class CancelExchangeRepositpryIml implements CancelExchangeRepositpry {
  @override
  Future<bool> cancelExchange(int orderID) async {
    try {
      var dio = Dio();
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/exchange/cancelExchange";
      Map data = {"idRequest": orderID};
      final reponse = await dio.post(url, data: data);
      if (reponse.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw Exception(e.response.statusMessage);
    }
  }
}
