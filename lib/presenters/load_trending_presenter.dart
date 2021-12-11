import 'package:old_change_app/data/repositories/load_trending_repository.dart';
import 'package:old_change_app/models/trending.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class LoadTrendingContract {
  void onTrendingSuccess(List<Trending> list);
  void onTrendingError(String er);
}

class LoadTrendingPresenter {
  LoadTrendingContract _view;
  LoadTrendingRepository _repository;
  LoadTrendingPresenter(this._view) {
    _repository = Injector().loadTrendingRepository();
  }
  void onLoad() {
    assert(_view != null && _repository != null);
    _repository
        .loadTrend()
        .then((value) => _view.onTrendingSuccess(value))
        .catchError((onError) => _view.onTrendingError(onError.toString()));
  }
}
