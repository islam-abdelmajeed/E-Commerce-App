import 'package:flutter/cupertino.dart';

class CountProduct extends ChangeNotifier {
  int counter = 1;

  increase() {
    counter++;
    notifyListeners();
  }

  decrease() {
    if (counter > 1) counter--;
    notifyListeners();
  }
}
