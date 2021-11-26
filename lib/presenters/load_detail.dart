import 'package:old_change_app/data/repositories/load_product_detail_repository.dart';
import 'package:old_change_app/models/input/product_detail.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class LoadProductDetailContract {
  void onLoadDetailSuccess(ProductDetail item);
  void onLoadDetailError(String error);
}

class LoadProductDetailPresenter {
  LoadProductDetailContract _view;
  LoadProductDetailRepository _repository;
  LoadProductDetailPresenter(this._view) {
    _repository = Injector().loadDetail();
  }
  void onLoad(int productID) {
    assert(_view != null && _repository != null);
    _repository
        .loadDetail(productID)
        .then((value) => _view.onLoadDetailSuccess(value))
        .catchError((onError) => _view.onLoadDetailError(onError.toString()));
  }
}
