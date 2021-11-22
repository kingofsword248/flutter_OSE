import 'package:old_change_app/utilities/dependency_injection.dart';
import 'package:old_change_app/data/repositories/accept_request_sell_reponsitory.dart';

abstract class AcceptReuqestContract {
  void onRequestSuccess(bool isComplete);
  void onRequestError(String error);
}

class AcceptRequestPresenter {
  AcceptReuqestContract _view;
  AcceptReuqestRepository _repository;
  AcceptRequestPresenter(this._view) {
    _repository = Injector().acceptRequest();
  }
  void onLoad(String id) {
    assert(_view != null && _repository != null);
    _repository
        .acceptRequest(id)
        .then((value) => _view.onRequestSuccess(value))
        .catchError((onError) => _view.onRequestError(onError.toString()));
  }
}
