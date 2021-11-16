import 'package:old_change_app/data/dependency_injection.dart';
import 'package:old_change_app/data/repositories/sign_up_reponsitory.dart';
import 'package:old_change_app/models/input/sign_up_form.dart';

abstract class SignUpContract {
  void onSignUpSuccess(bool isComplete);
  void onSignUpError(String error);
}

class SignUpPresenter {
  SignUpContract _view;
  SignUpRepository _repository;
  SignUpPresenter(this._view) {
    _repository = Injector().signUp();
  }
  void register(SignUpFormDTO dto) {
    assert(_view != null && _repository != null);
    _repository
        .registerAccount(dto)
        .then((value) => _view.onSignUpSuccess(value))
        .catchError((onError) => _view.onSignUpError(onError.toString()));
  }
}
