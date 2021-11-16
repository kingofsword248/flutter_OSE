import 'package:dio/dio.dart';

abstract class AcceptReuqestRepository {
  Future<bool> acceptRequest(String idOrderDetail);
}

class AcceptReuqestRepositoryIml implements AcceptReuqestRepository {
  @override
  Future<bool> acceptRequest(String idOrderDetail) async {
    try {
      var dio = Dio();
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/orderDetail/acceptOrderDetail";
      Map data = {"idOrderDetail": idOrderDetail};
      final reponse = await dio.post(url, data: data);
      if (reponse.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw Exception("Error");
    }
  }
}
