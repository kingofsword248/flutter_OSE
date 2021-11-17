import 'package:dio/dio.dart';

abstract class CancelOrderDetailRepository {
  Future<bool> cancelOrderDetail(String id);
}

class CancelOrderDetailRepositoryIml implements CancelOrderDetailRepository {
  @override
  Future<bool> cancelOrderDetail(String id) async {
    try {
      var dio = Dio();
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/orderDetail/cancelOrderDetail";
      Map data = {"idOrderDetail": id};
      final reponse = await dio.post(url, data: data);
      if (reponse.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw Exception("Cancel Order is error");
    }
  }
}
