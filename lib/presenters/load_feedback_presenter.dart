import 'package:old_change_app/data/repositories/load_feedback_repository.dart';
import 'package:old_change_app/models/input/feedback_form.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class LoadFeedBackContract {
  void onloadFeedBackSuccess(FeedbackForm form);
  void onLoadFeedbackError(String error);
}

class LoadFeedBackPresenter {
  LoadFeedBackContract _view;
  LoadFeedbackRepository _repository;
  LoadFeedBackPresenter(this._view) {
    _repository = Injector().loadFeedback();
  }
  void onLoad(int productID) {
    assert(_view != null && _repository != null);
    _repository
        .loadFeedback(productID)
        .then((value) => _view.onloadFeedBackSuccess(value))
        .catchError((onError) => _view.onLoadFeedbackError(onError.toString()));
  }
}
