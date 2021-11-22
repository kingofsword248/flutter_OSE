import 'package:old_change_app/utilities/dependency_injection.dart';
import 'package:old_change_app/data/repositories/cancel_order_detail_reponsitory.dart';

abstract class CancelOrderDetailContract {
  void onCancelOrderComplete(bool isSuccess);
  void onCancelOrderError(String error);
}

class CancelOrderDetailPresenter {
  CancelOrderDetailContract _view;
  CancelOrderDetailRepository _repository;
  CancelOrderDetailPresenter(this._view) {
    _repository = Injector().cancelOrderDetail();
  }
  void cancelOrder(String id) {
    assert(_view != null && _repository != null);
    _repository
        .cancelOrderDetail(id)
        .then((value) => _view.onCancelOrderComplete(value))
        .catchError((onError) => _view.onCancelOrderError(onError.toString()));
  }
}
