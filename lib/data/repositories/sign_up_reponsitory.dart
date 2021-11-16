import 'package:dio/dio.dart';
import 'package:old_change_app/models/input/sign_up_form.dart';
import 'package:old_change_app/screens/sign_up/widgets/sign_up_form.dart';

abstract class SignUpRepository {
  Future<bool> registerAccount(SignUpFormDTO form);
}

class SignUpRepositoryIml implements SignUpRepository {
  @override
  Future<bool> registerAccount(SignUpFormDTO form) async {
    try {
      var dio = Dio();
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/users/register";
      final reponse = await dio.post(url, data: form.toJson());
      if (reponse.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 500) {
        throw Exception("User already exists");
      } else {
        throw Exception(e.message);
      }
    }
  }
}
