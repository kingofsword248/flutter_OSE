import 'package:old_change_app/data/repositories/send_refund_repository.dart';
import 'package:old_change_app/models/input/feedback_request.dart';
import 'package:old_change_app/utilities/dependency_injection.dart';

abstract class SendRefundRequestContract {
  void onSendSuccess(bool success);
  void onSendError(String error);
}

class SendRefundPresenter {
  SendRefundRequestContract _view;
  SendRefundRequestRepository _repository;
  SendRefundPresenter(this._view) {
    _repository = Injector().sendRefund();
  }
  void onSend(FeedbackRequest request) {
    assert(_view != null && _repository != null);
    _repository
        .sendRequest(request)
        .then((value) => _view.onSendSuccess(value))
        .catchError((onError) => _view.onSendError(onError.toString()));
  }
}
