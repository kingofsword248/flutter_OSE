import 'package:old_change_app/data/repositories/disagree_refund_seller_repository.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class DisagreeRefundContract {
  void onDisagreeSuccess(String success);
  void onDisagreeError(String er);
}

class DisagreeRefundPresenter {
  DisagreeRefundContract _view;
  DisagreeRefundRepository _repository;
  DisagreeRefundPresenter(this._view) {
    _repository = Injector().disagreeRefund();
  }
  void onLoad(String reason, int idOrder) {
    assert(_view != null && _repository != null);
    _repository
        .disagree(idOrder, reason)
        .then((value) => _view.onDisagreeSuccess(value))
        .catchError((onError) => _view.onDisagreeError(onError.toString()));
  }
}
