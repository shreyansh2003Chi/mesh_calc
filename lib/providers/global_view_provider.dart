import 'package:flutter/material.dart';

class GlobalViewProvider with ChangeNotifier {
  bool isGridView = true;

  void changeView() {
    isGridView = !isGridView;
    notifyListeners();
  }
}
