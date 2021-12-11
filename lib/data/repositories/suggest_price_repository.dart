import 'package:dio/dio.dart';
import 'package:old_change_app/models/price.dart';

abstract class SuggestPriceRepository {
  Future<String> suggestPrice(int id);
}

class SuggestPriceRepositoryIml implements SuggestPriceRepository {
  @override
  Future<String> suggestPrice(int id) async {
    var dio = Dio();
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/crawlData/suggestPrice";
    try {
      Map map = {"idCategory": id};
      final response = await dio.post(url, data: map);
      if (response.statusCode == 200) {
        PriceSuggest rs = PriceSuggest.fromJson(response.data);
        return rs.priceSuggest;
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
