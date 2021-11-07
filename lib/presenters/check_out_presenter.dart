import 'package:old_change_app/data/dependency_injection.dart';
import 'package:old_change_app/data/repositories/check_out_reponsitory.dart';
import 'package:old_change_app/data/dependency_injection.dart';
import 'package:old_change_app/models/cart_request.dart';

abstract class CheckOutContract {
  void onPressCheckout(Result value);
  void OnCheckOutError(String error);
}

class CheckOutPresenter {
  CheckOutContract _view;
  CheckOutRepository _repository;
  CheckOutPresenter(this._view) {
    _repository = Injector().checkOutRepository();
  }
  void checkOut(CartRequest cartRequest, String token) {
    assert(_view != null && _repository != null);
    _repository
        .checkOut(token, cartRequest)
        .then((value) => _view.onPressCheckout(value))
        .catchError((onError) {
      print(onError);
      _view.OnCheckOutError(onError.toString());
    });
  }
}
