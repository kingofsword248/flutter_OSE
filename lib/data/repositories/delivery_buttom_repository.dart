import 'package:dio/dio.dart';

abstract class DeliveryButtomRepository {
  Future<String> delivery(int id);
}

class DeliveryButtomRepositoryIml implements DeliveryButtomRepository {
  @override
  Future<String> delivery(int id) async {
    try {
      var dio = Dio();
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/transport/delivery";
      Map data = {"idTransport": id};
      final reponse = await dio.post(url, data: data);
      if (reponse.statusCode == 200) {
        return reponse.data.toString();
      } else {
        return reponse.data.toString();
      }
    } on DioError catch (e) {
      throw Exception("delivery is error");
    }
  }
}
