import 'package:old_change_app/data/repositories/suggest_price_repository.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class SuggestPriceContract {
  void onSuggestSuccess(String price);
  void onSuggestError(String er);
}

class SuggestPricePresenter {
  SuggestPriceContract _view;
  SuggestPriceRepository _repository;
  SuggestPricePresenter(this._view) {
    _repository = Injector().suggestPriceRepository();
  }
  void onLoad(int id) {
    assert(_view != null && _repository != null);
    _repository
        .suggestPrice(id)
        .then((value) => _view.onSuggestSuccess(value))
        .catchError((onError) => _view.onSuggestError(onError.toString()));
  }
}
