import 'package:old_change_app/data/repositories/delivery_buttom_repository.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class DeliveryContract {
  void onDeliverySuccess(String s);
  void onDeliveryError(String e);
}

class DeliveryPresenter {
  DeliveryContract _view;
  DeliveryButtomRepository _repository;
  DeliveryPresenter(this._view) {
    _repository = Injector().delivery();
  }
  void onLoad(int id) {
    assert(_view != null && _repository != null);
    _repository
        .delivery(id)
        .then((value) => _view.onDeliverySuccess(value))
        .catchError((onError) => _view.onDeliveryError(onError));
  }
}
