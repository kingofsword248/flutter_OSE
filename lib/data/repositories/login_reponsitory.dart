import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:old_change_app/models/login_form.dart';
import 'package:old_change_app/models/user.dart';

abstract class LoginRepository {
  Future<User> signIn(LoginForm loginForm);
}

class LoginRepositoryIml implements LoginRepository {
  @override
  Future<User> signIn(LoginForm loginForm) async {
    String url = "https://old-stuff-exchange-api.herokuapp.com/api/users/login";
    final reponse = await http.post(Uri.parse(url), body: loginForm.toJson());
    if (reponse.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('User', reponse.body);
      // User a = User.fromJson(json.decode(prefs.get('User')));
      // print(a.address);
      return User.fromJson(json.decode(reponse.body));
    } else {
      throw Exception("Loi dang nhap");
    }
  }
}
