import 'dart:io';

import 'package:old_change_app/data/dependency_injection.dart';
import 'package:old_change_app/data/repositories/load_image_reponsitory.dart';
import 'package:old_change_app/models/input/post_image_result.dart';

abstract class LoadImageContract {
  void onLoadImageComplete(ImageResult result);
  void onLoadImageError(String error);
}

class LoadImagePresenter {
  LoadImageContract _view;
  LoadImageRepository _repository;
  LoadImagePresenter(this._view) {
    _repository = Injector().getImagePaths();
  }
  void loadImage(File file) {
    assert(_view != null && _repository != null);
    _repository
        .fetchImage(file)
        .then((value) => _view.onLoadImageComplete(value))
        .catchError((onError) => _view.onLoadImageError(onError.toString()));
  }
}
