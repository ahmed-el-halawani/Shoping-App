import 'package:flutter/cupertino.dart';

class AnimationProvider extends ChangeNotifier {
  int sliderSelectedIndex = 0;
  bool isSliderScrolling = false;


  void setIsSliderScrolling(bool state) {
    isSliderScrolling = state;
    notifyListeners();
  }

  void setSliderIndex(int index) {
    sliderSelectedIndex = index;
    notifyListeners();
  }


}
