import 'package:dio/dio.dart';
import 'package:old_change_app/models/input/feedback_request.dart';

abstract class SendRefundRequestRepository {
  Future<bool> sendRequest(FeedbackRequest request);
}

class SendRefundRequestRepositoryIml implements SendRefundRequestRepository {
  @override
  Future<bool> sendRequest(FeedbackRequest request) async {
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/refund/requestRefund";
    var dio = Dio();
    try {
      final response = await dio.post(url, data: request.toJson());
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
