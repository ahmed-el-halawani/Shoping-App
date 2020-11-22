import 'dart:async';

import 'package:clothes_demo_app/control/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FadeOutWidget extends StatefulWidget {
  final Widget child;

  FadeOutWidget({this.child});

  @override
  _FadeOutWidgetState createState() => _FadeOutWidgetState();
}

class _FadeOutWidgetState extends State<FadeOutWidget>
    with TickerProviderStateMixin {
  bool isFirst = true;
  StreamSubscription stream;
  AnimationController animCont;
  AnimationController animCont2;
  Animation anim;
  Animation anim2;
  var listener;
  bool removePage = false;

  @override
  void initState() {
    super.initState();
    animCont =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    anim = Tween(begin: Offset(0, 0), end: Offset(1, 0))
        .animate(CurvedAnimation(parent: animCont, curve: Curves.ease));
    animCont2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    anim2 = Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: animCont2, curve: Curves.linear));
    animCont2.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    NavigatorProvider nav = Provider.of<NavigatorProvider>(context);

    if (nav.changing) {
      if (nav.changeKey == AnimationKey.open) {
        animCont.reset();
        animCont.forward();
        nav.changing = false;
        print(nav.stack.length);
      } else {
        animCont.reset();
        animCont.forward();

        if (nav.stack.isEmpty) {
          animCont2.reset();
          animCont2.forward();
        }
        nav.changing = false;
        removePage = false;
      }
    }

    if (listener == null) {
      listener = (status) {
        if (status == AnimationStatus.completed) {
          if (nav.changeKey == AnimationKey.close) {
            nav.stack.clear();
            animCont.reverse();
          }
          if (nav.changeKey == AnimationKey.open && nav.stack.isNotEmpty) {
            removePage = true;
          }
        }
      };
      animCont.addStatusListener(listener);
    }

    return AnimatedBuilder(
      animation: nav.stack.isNotEmpty ? anim : anim2,
      builder: (con, w) => Stack(
        children: [
          nav.pages[nav.pageIndex],
          if (anim2.value == 0)
            Container()
          else
            Container(
              color: Colors.white.withOpacity(anim2.value),
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (stream != null) stream.cancel();
    animCont.dispose();
    super.dispose();
  }
}
