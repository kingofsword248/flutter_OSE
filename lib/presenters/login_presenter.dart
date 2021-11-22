import 'package:old_change_app/utilities/dependency_injection.dart';
import 'package:old_change_app/data/repositories/login_reponsitory.dart';
import 'package:old_change_app/models/login_form.dart';
import 'package:old_change_app/models/user.dart';

abstract class LoginContract {
  void onLoginComplete(User user);
  void onLoginError();
}

class LoginPresenter {
  LoginContract _view;
  LoginRepository _repository;
  LoginPresenter(this._view) {
    _repository = new Injector().signInReponsitory();
  }
  void login(LoginForm loginForm) {
    assert(_view != null && _repository != null);
    _repository
        .signIn(loginForm)
        .then((value) => _view.onLoginComplete(value))
        .catchError((onError) {
      // ignore: avoid_print
      print(onError);
      _view.onLoginError();
    });
  }
}
