import 'package:old_change_app/utilities/dependency_injection.dart';
import 'package:old_change_app/data/repositories/categories_reponsitory.dart';
import 'package:old_change_app/models/input/category_request.dart';

abstract class CategoryContract {
  void onLoadListCategory(List<CategoryRequest> lists);
  void onLoadListCategoryError(String onError);
}

class CategoryPresenter {
  CategoryContract _view;
  CategoriesRepository _repository;
  CategoryPresenter(this._view) {
    _repository = new Injector().getCategories();
  }
  void loadCategory() {
    assert(_view != null && _repository != null);
    _repository
        .fetchCategory()
        .then((value) => _view.onLoadListCategory(value))
        .catchError(
            (onError) => _view.onLoadListCategoryError(onError.toString()));
  }
}
