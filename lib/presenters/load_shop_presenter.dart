import 'package:old_change_app/data/repositories/load_shop_repository.dart';
import 'package:old_change_app/models/info.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class LoadShopContract {
  void onShopSuccess(Info info);
  void onShopEr(String er);
}

class LoadShopPresenter {
  LoadShopContract _view;
  LoadShopRepository _repository;
  LoadShopPresenter(this._view) {
    _repository = Injector().loadShopRepository();
  }
  void onLoad(int id) {
    assert(_view != null && _repository != null);
    _repository
        .loadShop(id)
        .then((value) => _view.onShopSuccess(value))
        .catchError((onError) => _view.onShopEr(onError.toString()));
  }
}
