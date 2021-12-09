import 'package:old_change_app/data/repositories/load_refund_sell.dart';
import 'package:old_change_app/models/refund.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class RefundSellContract {
  void onLoadRefundSuccess(List<RefundDTO> list);
  void onLoadRefundError(String e);
}

class RefundSellPresenter {
  RefundSellContract _view;
  RefundSellRepository _repository;
  RefundSellPresenter(this._view) {
    _repository = Injector().loadRefundS();
  }
  void onLoad(int id) {
    assert(_view != null && _repository != null);
    _repository
        .loadRefundP(id)
        .then((value) => _view.onLoadRefundSuccess(value))
        .catchError((onError) => _view.onLoadRefundError(onError.toString()));
  }
}
