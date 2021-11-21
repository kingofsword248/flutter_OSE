import 'dart:async';

import 'package:dio/dio.dart';
import 'package:old_change_app/models/user.dart';

abstract class FetchUserRepositoty {
  Future<Userr> fetchUser(String token);
}

class FetchUserRepositotyIml implements FetchUserRepositoty {
  @override
  Future<Userr> fetchUser(String token) async {
    var dio = Dio();
    try {
      String url =
          "https://old-stuff-exchange-api.herokuapp.com/api/users/profile";
      dio.options.headers["authorization"] = "Bearer " + token.toString();
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return Userr.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      throw Exception(e.response.statusMessage);
    }
  }
}
