import 'package:old_change_app/utilities/dependency_injection.dart';
import 'package:old_change_app/data/repositories/post_product_reponsitory.dart';
import 'package:old_change_app/data/repositories/post_review_repository.dart';
import 'package:old_change_app/models/input/reviews_form.dart';
import 'package:old_change_app/presenters/post_product_presenter.dart';

abstract class PostReviewContract {
  void onPostReviewSuccess(bool success);
  void onPostReviewError(String error);
}

class PostReviewPresenter {
  PostReviewContract _view;
  PostReviewRepository _repository;
  PostReviewPresenter(this._view) {
    _repository = Injector().postReview();
  }
  void onPostReview(ReviewsForm form, String token) {
    assert(_view != null && _repository != null);
    _repository
        .postReview(form, token)
        .then((value) => _view.onPostReviewSuccess(value))
        .catchError((onError) => _view.onPostReviewError(onError.toString()));
  }
}
