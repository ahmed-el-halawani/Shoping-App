import 'package:clothes_demo_app/view/value/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading2 extends StatefulWidget {
  final bool condition;

  Loading2(this.condition);

  @override
  _Loading2State createState() => _Loading2State();
}

class _Loading2State extends State<Loading2> with TickerProviderStateMixin {
  double ob = 1.0;
  bool remove = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.condition) {
      ob = 1;
    } else {
      Future.delayed(Duration(milliseconds: 400), () {
        setState(() {
          ob = 0;
        });
      });
    }

    return remove
        ? Container(
            width: 0,
            height: 0,
          )
        : AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            onEnd: () {
              setState(() {
                remove = true;
              });
            },
            color: Colors.white.withOpacity(ob),
            child: ob == 0
                ? null
                : Center(
                    child: SpinKitCircle(
                      color: MyColors.primary,
                      size: 50.0,
                      controller: AnimationController(
                        vsync: this,
                        duration: const Duration(milliseconds: 1000),
                      ),
                    ),
                  ),
          );
  }
}
