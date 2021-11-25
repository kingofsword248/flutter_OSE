import 'package:old_change_app/data/repositories/cancel_exchange_request_repository.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class CancelExchangeContract {
  void onCancelSuccess(bool success);
  void onCancelError(String error);
}

class CancelEchangePresenter {
  CancelExchangeContract _view;
  CancelExchangeRepositpry _repositpry;
  CancelEchangePresenter(this._view) {
    _repositpry = Injector().cancelExchange();
  }
  void onCancel(int id) {
    assert(_view != null && _repositpry != null);
    _repositpry
        .cancelExchange(id)
        .then((value) => _view.onCancelSuccess(value))
        .catchError((onError) => _view.onCancelError(onError));
  }
}
