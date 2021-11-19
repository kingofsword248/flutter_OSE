import 'package:old_change_app/data/dependency_injection.dart';
import 'package:old_change_app/data/repositories/confirm_purchase_repository.dart';

abstract class ConfirmPurchaseContract {
  void onLoadConfirmSuccess(bool Success);
  void onErrorConfirmError(String onError);
}

class ConfirmPurchasePresenter {
  ConfirmPurchaseRepository _repository;
  ConfirmPurchaseContract _view;
  ConfirmPurchasePresenter(this._view) {
    _repository = Injector().confirmPurchase();
  }
  void confirm(String id) {
    assert(_view != null && _repository != null);
    _repository
        .confirm(id)
        .then((value) => _view.onLoadConfirmSuccess(value))
        .catchError((onError) => _view.onErrorConfirmError(onError));
  }
}
