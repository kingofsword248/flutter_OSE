import 'package:old_change_app/data/repositories/join_exchange_repository.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class JoinExchangeContract {
  void onjoinSuccess(bool s);
  void onJoinError(String error);
}

class JoinExchangePresenter {
  JoinExchangeContract _view;
  joinExchangeRepository _repository;
  JoinExchangePresenter(this._view) {
    _repository = Injector().joinExchange();
  }
  void onLoad(String token, String map) {
    assert(_view != null && _repository != null);
    _repository
        .joinExchange(token, map)
        .then((value) => _view.onjoinSuccess(value))
        .catchError((onError) => _view.onJoinError(onError.toString()));
  }
}
