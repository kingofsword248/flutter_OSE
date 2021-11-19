import 'package:dio/dio.dart';

abstract class ConfirmPurchaseRepository {
  Future<bool> confirm(String id);
}

class ConfirmPurchaseRepositoryIml implements ConfirmPurchaseRepository {
  @override
  Future<bool> confirm(String id) async {
    try {
      var dio = Dio();
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/orderDetail/receiveProduct";
      Map data = {"idOrderDetail": id};
      final reponse = await dio.post(url, data: data);
      if (reponse.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw Exception("Confirm got error");
    }
  }
}
