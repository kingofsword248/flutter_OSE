import 'package:old_change_app/data/repositories/accept_echange_request.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class AcceptExchangeReuqestContract {
  void onAcceptSuccess(bool success);
  void onAcceptError(String error);
}

class AcceptExchangeReuqestPresenter {
  AcceptExchangeReuqestRepository _repository;
  AcceptExchangeReuqestContract _view;
  AcceptExchangeReuqestPresenter(this._view) {
    _repository = Injector().acceptExchangRequest();
  }
  void onLoad(int id, String token) {
    assert(_view != null && _repository != null);
    _repository
        .acceptExchangeRequest(id, token)
        .then((value) => _view.onAcceptSuccess(value))
        .catchError((onError) => _view.onAcceptError(onError.toString()));
  }
}
