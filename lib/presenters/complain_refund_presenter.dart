import 'package:old_change_app/data/repositories/complain_refund_repository.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class ComplainRefundContract {
  void onComplainSuccess(String mess);
  void onComplainError(String e);
}

class ComplainPresenter {
  ComplainRefundContract _view;
  ComplainRefundRepository _repository;
  ComplainPresenter(this._view) {
    _repository = Injector().complainRefund();
  }
  void onLoad(int idOrderDetail) {
    assert(_view != null && _repository != null);
    _repository
        .complainRefund(idOrderDetail)
        .then((value) => _view.onComplainSuccess(value))
        .catchError((onError) => _view.onComplainError(onError.toString()));
  }
}
