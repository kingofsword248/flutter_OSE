import 'package:old_change_app/utilities/dependency_injection.dart';
import 'package:old_change_app/data/repositories/fetch_user_repository.dart';
import 'package:old_change_app/models/user.dart';

abstract class FetchUserContract {
  void onFetchUserSuccess(Userr user);
  void onFetchUserError(String onError);
}

class FetchUserPresenter {
  FetchUserContract _view;
  FetchUserRepositoty _repositoty;
  FetchUserPresenter(this._view) {
    _repositoty = Injector().fetchUser();
  }
  void onFetch(String token) {
    assert(_view != null && _repositoty != null);
    _repositoty
        .fetchUser(token)
        .then((value) => _view.onFetchUserSuccess(value))
        .catchError((onError) => _view.onFetchUserError(onError.toString()));
  }
}
