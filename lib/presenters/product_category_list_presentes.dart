import 'package:old_change_app/data/dependency_injection.dart';
import 'package:old_change_app/data/repositories/product_list_reponsitory.dart';
import 'package:old_change_app/models/product_real.dart';

abstract class ProductListViewContrat {
  void onLoadProductComplete(List<Product> products);
  void onLoadProductError();
}

class ProductListPresenters {
  ProductListViewContrat _view;
  ProductListReponsitory _reponsitory;
  ProductListPresenters(this._view) {
    _reponsitory = new Injector().getProductListReponsitory();
  }
  void loadProduct(String input) {
    assert(_view != null && _reponsitory != null);
    _reponsitory
        .fetchProduct(input)
        .then((value) => _view.onLoadProductComplete(value))
        .catchError((onError) {
      print(onError);
      _view.onLoadProductError();
    });
  }
}
