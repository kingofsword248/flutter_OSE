import 'package:old_change_app/data/repositories/get_list_exchange_repository.dart';
import 'package:old_change_app/models/input/exchange_result_list.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class GetExchangeRequestContract {
  void onLoadExchangesSuccess(List<ExchangeForm> list);
  void onLoadExchangesError(String OnError);
}

class GetExchangeRequestPresenter {
  GetExchangeRequestContract _view;
  GetExchangeRequestRepository _repository;
  GetExchangeRequestPresenter(this._view) {
    _repository = Injector().getList();
  }
  void onLoad(String myID, String type) {
    assert(_view != null && _repository != null);
    _repository
        .getList(myID, type)
        .then((value) => _view.onLoadExchangesSuccess(value))
        .catchError(
            (onError) => _view.onLoadExchangesError(onError.toString()));
  }
}
