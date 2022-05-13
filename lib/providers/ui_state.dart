import 'package:flutter/material.dart';

class UIstate extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  set slectedMenuOpt(int i) {
    _selectedMenuOpt = i;
    notifyListeners();
  }
}
