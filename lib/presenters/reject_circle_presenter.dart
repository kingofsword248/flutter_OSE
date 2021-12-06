import 'package:old_change_app/data/repositories/reject_exchange_repository.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class RejectCircleContract {
  void onRejectSuccess(bool s);
  void onRejectError(String error);
}

class RejectCirclePresenter {
  RejectCircleContract _view;
  RejectCircleRepository _repository;
  RejectCirclePresenter(this._view) {
    _repository = Injector().rejectCircle();
  }
  void onLoad(String token, String map) {
    assert(_view != null && _repository != null);
    _repository
        .onRejectSuccess(token, map)
        .then((value) => _view.onRejectSuccess(value))
        .catchError((onError) => _view.onRejectError(onError));
  }
}
