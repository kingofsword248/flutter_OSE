import 'package:old_change_app/data/repositories/exchang_product_repository.dart';
import 'package:old_change_app/models/cart_request.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class ExchangeProductContract {
  void onExchangeSuccess(Result rs);
  void onExchangeError(String error);
}

class ExchangeProductPresenter {
  ExchangeProductContract _view;
  ExchangeProductRepository _repository;
  ExchangeProductPresenter(this._view) {
    _repository = Injector().exchangeProduct();
  }
  void onLoad(int myID, int myProductID, int theirProductID) {
    assert(_view != null && _repository != null);
    _repository
        .exchange(myID, myProductID, theirProductID)
        .then((value) => _view.onExchangeSuccess(value))
        .catchError((onError) => _view.onExchangeError(onError));
  }
}
