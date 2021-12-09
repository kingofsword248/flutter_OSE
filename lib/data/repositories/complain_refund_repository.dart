import 'package:dio/dio.dart';

abstract class ComplainRefundRepository {
  Future<String> complainRefund(int idOrderDetail);
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

class ComplainRefundRepositoryIml implements ComplainRefundRepository {
  @override
  Future<String> complainRefund(int idOrderDetail) async {
    try {
      var dio = Dio();
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/refund/reportAdmin";
      Map data = {"idOrderDetail": idOrderDetail};
      final reponse = await dio.post(url, data: data);
      if (reponse.statusCode == 200) {
        Result rs = Result.fromJson(reponse.data);
        return rs.message;
      } else {
        Exception("Complain got error");
        ;
      }
    } on DioError catch (e) {
      throw Exception("Complain got error");
    }
  }
}
