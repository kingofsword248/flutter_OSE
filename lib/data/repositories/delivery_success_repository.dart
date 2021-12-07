import 'package:dio/dio.dart';

abstract class DeliverySuccessRepository {
  Future<String> deliverySuccess(int id);
}

class DeliverySuccessRepositoryIml implements DeliverySuccessRepository {
  @override
  Future<String> deliverySuccess(int id) async {
    try {
      var dio = Dio();
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/transport/successDelivery";
      Map data = {"idTransport": "$id"};
      final reponse = await dio.post(url, data: data);
      if (reponse.statusCode == 200) {
        return reponse.data.toString();
      } else {
        return reponse.data.toString();
      }
    } on DioError catch (e) {
      throw Exception("deliverySuccess is error");
    }
  }
}
