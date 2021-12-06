import 'package:old_change_app/data/repositories/circle_home_repository.dart';
import 'package:old_change_app/models/input/cicle_screen1.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class CircleHomeContrat {
  void onLoadCircleSuccess(List<CircleHome> list);
  void onLoadCircleError(String error);
}

class CircleHomePresenter {
  CircleHomeContrat _view;
  CircleHomeRepository _repository;
  CircleHomePresenter(this._view) {
    _repository = Injector().getCicleHome();
  }
  void onLoad(String token) {
    assert(_view != null && _repository != null);
    _repository
        .getCircleHome(token)
        .then((value) => _view.onLoadCircleSuccess(value))
        .catchError((onError) => _view.onLoadCircleError(onError.toString()));
  }
}
