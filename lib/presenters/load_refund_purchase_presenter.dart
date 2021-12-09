import 'package:old_change_app/data/repositories/load_refund_purchase_repository.dart';
import 'package:old_change_app/models/refund.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class RefundPurchaseContract {
  void onLoadRefundSuccess(List<RefundDTO> list);
  void onLoadRefundError(String e);
}

class RefundPurchasePresenter {
  RefundPurchaseContract _view;
  RefundPurchaseRepository _repository;
  RefundPurchasePresenter(this._view) {
    _repository = Injector().loadRefundP();
  }
  void onLoad(int id) {
    assert(_view != null && _repository != null);
    _repository
        .loadRefundP(id)
        .then((value) => _view.onLoadRefundSuccess(value))
        .catchError((onError) => _view.onLoadRefundError(onError.toString()));
  }
}
