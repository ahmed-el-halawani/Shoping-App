import 'package:clothes_demo_app/control/main_provider.dart';
import 'package:clothes_demo_app/view/value/color.dart';
import 'package:clothes_demo_app/view/value/dimon.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class Switcher extends StatefulWidget {
  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  int sliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    MainProvider main = Provider.of<MainProvider>(context);
    print(MyDemon.width(context) * .1);

    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                color: Colors.red,
                iconSize: 30,
                padding: EdgeInsets.symmetric(
                    horizontal: MyDemon.width(context) * .1 > 38
                        ? MyDemon.width(context) * .14
                        : MyDemon.width(context) * .1,
                    vertical: 2),
                duration: Duration(milliseconds: 200),
                tabBackgroundColor: MyColors.primary,
                tabs: [
                  GButton(
                      borderRadius: BorderRadius.circular(7),
                      icon: LineIcons.cloud,
                      text: 'winter',
                      textStyle: MyStyle.onPrimaryTextStyle),
                  GButton(
                      borderRadius: BorderRadius.circular(7),
                      icon: LineIcons.sun_o,
                      text: 'summer',
                      textStyle: MyStyle.onPrimaryTextStyle),
                ],
                selectedIndex: main.sliderIndex,
                onTabChange: (index) {
                  main.changeSliderIndex(index);
                }),
          ),
        ));
  }
}
