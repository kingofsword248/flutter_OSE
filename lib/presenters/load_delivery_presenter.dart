import 'package:old_change_app/data/repositories/load_delivery_repository.dart';
import 'package:old_change_app/models/delivery.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class LoadDeliveryContract {
  void onLoadDeliverySuccess(List<Delivery> list);
  void onLoadDeliveryError(String error);
}

class LoadDeliveryPresenter {
  LoadDeliveryContract _view;
  LoadDeliveryRepository _repository;
  LoadDeliveryPresenter(this._view) {
    _repository = Injector().getDelivery();
  }
  void onLoad(String url) {
    assert(_view != null && _repository != null);
    _repository
        .getDelivery(url)
        .then((value) => _view.onLoadDeliverySuccess(value))
        .catchError((onError) => _view.onLoadDeliveryError(onError.toString()));
  }
}
