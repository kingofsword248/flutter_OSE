import 'package:old_change_app/data/repositories/load_category_reponsitory.dart';
import 'package:old_change_app/data/repositories/load_my_product_repository.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class LoadMyProductContract {
  void onLoadMyProductSuccess(List<Product> list);
  void onLoadMyProductError(String error);
}

class LoadMyProductPresenter {
  LoadMyProductContract _view;
  LoadMyProductRepository _repository;
  LoadMyProductPresenter(this._view) {
    _repository = Injector().loadMyProduct();
  }
  void onLoad(String token) {
    assert(_view != null && _repository != null);
    _repository
        .loadMyProduct(token)
        .then((value) => _view.onLoadMyProductSuccess(value))
        .catchError(
            (onError) => _view.onLoadMyProductError(onError.toString()));
  }
}
