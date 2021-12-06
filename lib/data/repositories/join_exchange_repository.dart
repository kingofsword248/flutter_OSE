import 'package:dio/dio.dart';

abstract class joinExchangeRepository {
  Future<bool> joinExchange(String token, String map);
}

class joinExchangeRepositoryIml implements joinExchangeRepository {
  @override
  Future<bool> joinExchange(String token, String map) async {
    var dio = Dio();
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/suggestMapping/joinCirleExchange";
    Map data = {"tradeMappingCode": map};
    try {
      dio.options.headers["Authorization"] = "Bearer " + token.toString();
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw Exception(e.response.statusMessage);
    }
  }
}
