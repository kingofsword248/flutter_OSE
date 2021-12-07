import 'package:dio/dio.dart';

abstract class UpdateStatusRepository {
  Future<String> updateStatus(int id, String status);
}

class UpdateStatusRepositoryIml implements UpdateStatusRepository {
  @override
  Future<String> updateStatus(int id, String status) async {
    try {
      var dio = Dio();
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/transport/upDateStatusDelivery";
      Map data = {"idTransport": id, "status": status};
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
