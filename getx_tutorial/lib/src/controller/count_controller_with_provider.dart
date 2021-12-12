import 'package:flutter/cupertino.dart';

class CountControllerWithProvider extends ChangeNotifier{
  int count = 0;

  void increase(){
    count++;
    notifyListeners();
  }
}