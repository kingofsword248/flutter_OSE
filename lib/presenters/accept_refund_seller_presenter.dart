import 'package:old_change_app/data/repositories/accept_refund_seller_repository.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class AcceptRefundSellerContract {
  void onAcceptSuccess(String ss);
  void onAcceptError(String er);
}

class AcceptRefundSellerPresenter {
  AcceptRefundSellerContract _view;
  AcceptRefundSellerRepository _repository;
  AcceptRefundSellerPresenter(this._view) {
    _repository = Injector().acceptRefundSellerRepository();
  }
  void onLoad(int idOrderDetail) {
    assert(_view != null && _repository != null);
    _repository
        .acceptRefund(idOrderDetail)
        .then((value) => _view.onAcceptSuccess(value))
        .catchError((onError) => _view.onAcceptError(onError.toString()));
  }
}
