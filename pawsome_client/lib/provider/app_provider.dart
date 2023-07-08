import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier{
  int _currentIndex = 4;

  int get currentIndex => _currentIndex;

  void changeIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }
  void clear(){
    _currentIndex = 4;
    notifyListeners();
  }
}