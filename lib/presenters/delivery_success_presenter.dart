import 'package:old_change_app/data/repositories/delivery_success_repository.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class DeliverySuccessContract {
  void onDeliverySS(String s);
  void onDelicerySE(String e);
}

class DeliverySuccessPresenter {
  DeliverySuccessContract _view;
  DeliverySuccessRepository _repository;
  DeliverySuccessPresenter(this._view) {
    _repository = Injector().deliverySuccess();
  }
  void onLoad(int id) {
    assert(_view != null && _repository != null);
    _repository
        .deliverySuccess(id)
        .then((value) => _view.onDeliverySS(value))
        .catchError((onError) => _view.onDelicerySE(onError.toString()));
  }
}
