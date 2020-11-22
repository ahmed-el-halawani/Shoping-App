import 'package:clothes_demo_app/view/pages/collections_home.dart';
import 'package:clothes_demo_app/view/pages/like_home.dart';
import 'package:clothes_demo_app/view/pages/place_holder.dart';
import 'package:clothes_demo_app/view/pages/profile_home.dart';
import 'package:clothes_demo_app/view/pages/search_home.dart';
import 'package:clothes_demo_app/view/pages/shopping_cart_home.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:clothes_demo_app/view/widget/grid_view.dart';
import 'package:clothes_demo_app/view/widget/slide_show.dart';
import 'package:clothes_demo_app/view/widget/switcher.dart';
import 'package:flutter/cupertino.dart';

enum AnimationKey { open, close }

class NavigatorProvider extends ChangeNotifier {
  List<Widget> pages = [
    CollectionHome(),
    LikesHome(),
    SearchHome(),
    ShoppingCart(),
    AdminHome(),
  ];

  List<Widget> stack = [];

  int pageIndex = 0;
  bool changing = false;
  int animation = 2;
  AnimationKey changeKey = AnimationKey.close;
  bool isBottomSheetOpened = false;

  BuildContext context;

  bool isImage = false;

  ImageProvider image;

  changeImageOpenState() {
    isImage = !isImage;
    notifyListeners();
  }

  void setImage(image) {
    image = image;
    notifyListeners();
  }

  void removeImage() {
    image = null;
    notifyListeners();
  }

  changePage(int index) {
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    pageIndex = index;
    customPop();
    notifyListeners();
  }

  customPushStack(Widget widget) {
    changing = true;
    changeKey = AnimationKey.open;
    stack.add(widget);
    notifyListeners();
  }

  customPop({BuildContext context}) {
    changing = true;
    changeKey = AnimationKey.close;
    notifyListeners();
  }
}
