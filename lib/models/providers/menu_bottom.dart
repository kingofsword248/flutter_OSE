import 'package:flutter/cupertino.dart';

class MenuBottomDT with ChangeNotifier {
  int _onSelectedIndex = 0;
  int get getSelectIndex {
    return _onSelectedIndex;
  }

  void setSelectedIndex(int index) {
    _onSelectedIndex = index;
    notifyListeners();
  }
}
