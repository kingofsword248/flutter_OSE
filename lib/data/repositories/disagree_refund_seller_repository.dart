import 'package:dio/dio.dart';

abstract class DisagreeRefundRepository {
  Future<String> disagree(int id, String reason);
}

class Result {
  String message;

  Result({this.message});

  Result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

class DisagreeRefundRepositoryIml implements DisagreeRefundRepository {
  @override
  Future<String> disagree(int id, String reason) async {
    var dio = Dio();
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/refund/shopRejectRefund";
    Map data = {"idOrderDetail": id, "reasonReject": reason};
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        Result rs = Result.fromJson(response.data);
        return rs.message;
      } else {
        throw Exception("error");
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
