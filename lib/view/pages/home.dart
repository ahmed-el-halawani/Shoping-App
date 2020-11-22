import 'dart:async';

import 'package:clothes_demo_app/control/main_provider.dart';
import 'package:clothes_demo_app/control/navigator_provider.dart';
import 'package:clothes_demo_app/view/widget/bottom_nav.dart';
import 'package:clothes_demo_app/view/widget/fade_out_widget.dart';
import 'package:clothes_demo_app/view/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainProvider prov = Provider.of<MainProvider>(context);
    NavigatorProvider nav = Provider.of<NavigatorProvider>(context);

    nav.context = context;

    return Stack(
      children: [
        Scaffold(
          body: SetBackpressed(
            child: FadeOutWidget(
              child: Stack(
                children: [
                  Consumer(
                    builder: (c, NavigatorProvider nav, _) {
                      if (nav.stack.isNotEmpty) {
                        return nav.stack.last;
                      } else {
                        return Container(
                          width: 0,
                          height: 0,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Loading2(prov.openFinish)
      ],
    );
  }
}

// ignore: must_be_immutable
class SetBackpressed extends StatelessWidget {
  BuildContext context;
  final Widget child;

  SetBackpressed({this.child});

  NavigatorProvider nav;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    nav = Provider.of<NavigatorProvider>(context);

    return WillPopScope(
      onWillPop: onBackPressed,
      child: child,
    );
  }

  bool back = false;
  StreamSubscription s;

  Future<bool> onBackPressed() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else if (nav.stack.isNotEmpty) {
      nav.customPop();
      return false;
    }
    if (!back) {
      print("press again to exit");
      back = true;
      s = Stream.fromFuture(Future.delayed(Duration(seconds: 5)))
          .listen((event) {
        print("stream");
        back = false;
      });
      return false;
    } else {}
    s.cancel();
    return true;
  }
}
