import 'package:dio/dio.dart';
import 'package:old_change_app/models/cart_request.dart';

abstract class ExchangeProductRepository {
  Future<Result> exchange(int myId, int myProductID, int theirProductID);
}

class ExchangeProductRepositoryIml implements ExchangeProductRepository {
  @override
  Future<Result> exchange(int myId, int myProductID, int theirProductID) async {
    var dio = Dio();
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/exchange/requestChange";
    try {
      Map body = {
        "id": myId,
        "idProductChange": myProductID,
        "idProductWantChange": theirProductID
      };
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        return Result.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      throw Exception(e.response.statusMessage);
    }
  }
}
