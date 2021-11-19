import 'dart:async';

import 'package:dio/dio.dart';
import 'package:old_change_app/models/user.dart';

abstract class FetchUserRepositoty {
  Future<User> fetchUser(String token);
}

class FetchUserRepositotyIml implements FetchUserRepositoty {
  @override
  Future<User> fetchUser(String token) async {
    var dio = Dio();
    try {
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/users/profile";
      dio.options.headers["authorization"] = "Bearer " + token.toString();
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception("token is wrong");
      }
    } on DioError catch (e) {
      throw Exception("Some thing went wrong");
    } on TimeoutException catch (e) {
      throw Exception("No internet");
    }
  }
}
