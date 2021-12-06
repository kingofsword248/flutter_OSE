import 'package:old_change_app/data/repositories/circle_one_repository.dart';
import 'package:old_change_app/models/input/cicle_one.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class CircleOneContract {
  void onOneSuccess(List<CircleOne> list);
  void onOneError(String onError);
}

class CircleOnePresenter {
  CircleOneContract _view;
  CircleOneRepository _repository;
  CircleOnePresenter(this._view) {
    _repository = Injector().getCircleOne();
  }
  void onLoad(int id) {
    assert(_view != null && _repository != null);
    _repository
        .getOne(id)
        .then((value) => _view.onOneSuccess(value))
        .catchError((onError) => _view.onOneError(onError.toString()));
  }
}
