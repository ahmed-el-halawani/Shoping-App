import 'package:clothes_demo_app/control/navigator_provider.dart';
import 'package:clothes_demo_app/control/user_provider.dart';
import 'package:clothes_demo_app/view/value/color.dart';
import 'package:clothes_demo_app/view/value/dimon.dart';
import 'package:clothes_demo_app/view/value/image_path.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class bottomNav2 extends StatefulWidget {
  @override
  _bottomNav2State createState() => _bottomNav2State();
}

class _bottomNav2State extends State<bottomNav2> {
  NavigatorProvider nave;

  @override
  Widget build(BuildContext context) {
    nave = Provider.of<NavigatorProvider>(context);
    UserProvider user = Provider.of<UserProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MyDemon.width(context) * .03, vertical: 8),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(
                horizontal: MyDemon.width(context) * .1 > 38
                    ? MyDemon.width(context) * .04
                    : MyDemon.width(context) * .035,
                vertical: 5),
            duration: Duration(milliseconds: 300),
            tabBackgroundColor: MyColors.primary,
            tabs: [
              GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  textStyle: MyStyle.onPrimaryTextStyleSmall),
              GButton(
                  icon: LineIcons.heart_o,
                  text: 'Likes',
                  textStyle: MyStyle.onPrimaryTextStyleSmall),
              GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                  textStyle: MyStyle.onPrimaryTextStyleSmall),
              GButton(
                text: 'Cart',
                textStyle: MyStyle.onPrimaryTextStyleSmall,
                leading: Container(
                  height: 25,
                  child: Image.asset(
                    nave.pageIndex == 3
                        ? ImagePath.shoppingCartEmptyWhite
                        : user.getBasketProductList().isEmpty
                            ? ImagePath.shoppingCartEmptyBlack
                            : ImagePath.shoppingCartNotEmpty,
                  ),
                ),
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
                textStyle: MyStyle.onPrimaryTextStyleSmall,
              ),
            ],
            selectedIndex: nave.pageIndex,
            onTabChange: (i) {
              nave.changePage(i);
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }
}
