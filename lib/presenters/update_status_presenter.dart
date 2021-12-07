import 'package:old_change_app/data/repositories/update_status_repository.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class UpdateStatusContract {
  void onUpdateSuccess(String success);
  void onUpdateError(String e);
}

class UpdateStatusPresenter {
  UpdateStatusContract _view;
  UpdateStatusRepository _repository;
  UpdateStatusPresenter(this._view) {
    _repository = Injector().updateStatus();
  }
  void onLoad(int id, String status) {
    assert(_view != null && _repository != null);
    _repository
        .updateStatus(id, status)
        .then((value) => _view.onUpdateSuccess(value))
        .catchError((onError) => _view.onUpdateError(onError));
  }
}
