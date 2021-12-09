import 'package:dio/dio.dart';

abstract class AcceptRefundSellerRepository {
  Future<String> acceptRefund(int id);
}

class Result {
  String result;

  Result({this.result});

  Result.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    return data;
  }
}

class AcceptRefundSellerRepositoryIml implements AcceptRefundSellerRepository {
  @override
  Future<String> acceptRefund(int id) async {
    var dio = Dio();
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/orderDetail/acceptRefund";
    Map data = {"idOrderDetail": id};
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        Result rs = Result.fromJson(response.data);
        return rs.result;
      } else {
        throw Exception("error");
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
