import 'package:old_change_app/utilities/dependency_injection.dart';
import 'package:old_change_app/data/repositories/purchase_order_reponsitory.dart';
import 'package:old_change_app/models/purchase_dto.dart';

abstract class PurchaseContract {
  void onLoadComplte(List<PurchaseDTO> list);
  void onLoadError(String error);
}

class PurchasePresenter {
  PurchaseContract _view;
  PurchaseOrderRepository _repository;
  PurchasePresenter(this._view) {
    _repository = Injector().getPurchaseList();
  }
  void loadPurchaseList(int id, String status, String model) {
    assert(_view != null && _repository != null);
    _repository
        .getPurchase(id, status, model)
        .then((value) => _view.onLoadComplte(value))
        .catchError((onError) => _view.onLoadError(onError.toString()));
  }
}
