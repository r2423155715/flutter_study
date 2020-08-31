import 'package:flutter/foundation.dart';

class Counter2 with ChangeNotifier {
  int _count = 0;
  bool _isLeft=true;
  int get count => _count;
  bool get isLeft=>_isLeft;

  void chageRight(){
    _isLeft=!_isLeft;
    notifyListeners();
  }
  void increment() {
    _count++;
    notifyListeners();
  }
  void jian() {
    _count--;
    notifyListeners();
  }
}