import 'package:dio/dio.dart';
import 'package:old_change_app/models/input/reviews_form.dart';

abstract class PostReviewRepository {
  Future<bool> postReview(ReviewsForm form, String token);
}

class PostReviewRepositoryIml implements PostReviewRepository {
  @override
  Future<bool> postReview(ReviewsForm form, String token) async {
    var dio = Dio();
    try {
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/users/feedback";
      dio.options.headers["Authorization"] = "Bearer " + token.toString();
      final response = await dio.post(url, data: form.toJson());
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (!e.response.statusMessage.contains("Unauthorized")) {
        throw Exception("You have feedback on this product");
      } else {
        throw Exception("Unauthorized");
      }
    }
  }
}
