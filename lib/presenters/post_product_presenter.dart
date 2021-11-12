import 'package:old_change_app/data/dependency_injection.dart';
import 'package:old_change_app/data/repositories/post_product_reponsitory.dart';
import 'package:old_change_app/models/input/post_product_result.dart';
import 'package:old_change_app/models/input/product_form.dart';

abstract class PostProductContract {
  void onPostProductComplete(PostProductResult ppr);
  void onPostProductError(String error);
}

class PostProductPresenter {
  PostProductContract _view;
  PostProductRepository _repository;
  PostProductPresenter(this._view) {
    _repository = new Injector().postProduct();
  }
  void postProduct(ProductPost productPost) {
    assert(_view != null && _repository != null);
    _repository
        .postProduct(productPost)
        .then((value) => _view.onPostProductComplete(value))
        .catchError((onError) => _view.onPostProductError(onError.toString()));
  }
}
