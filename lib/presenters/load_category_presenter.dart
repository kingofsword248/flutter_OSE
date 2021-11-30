import 'package:old_change_app/utilities/dependency_injection.dart';
import 'package:old_change_app/data/repositories/load_category_reponsitory.dart';
import 'package:old_change_app/models/category.dart';

abstract class LoadCategoryContract {
  void onLoadSuccess(List<Category> list);
  void onLoadError(String onError);
}

class LoadCategoryPresenter {
  LoadCategoryContract _view;
  LoadCategoryRepository _repository;
  LoadCategoryPresenter(this._view) {
    _repository = Injector().loadCategory();
  }
  void onLoad() {
    assert(_view != null && _repository != null);
    _repository
        .loadCategory()
        .then((value) => _view.onLoadSuccess(value))
        .catchError((onError) => _view.onLoadError(onError.toString()));
  }
}
