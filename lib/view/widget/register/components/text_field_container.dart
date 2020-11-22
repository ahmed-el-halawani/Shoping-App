import 'package:clothes_demo_app/view/value/dimon.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final bool error;
  final Color color;

  const TextFieldContainer(
      {Key key,
      this.child,
      this.error = false,
      this.color = kPrimaryLightColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MyDemon.width(context) * 0.8,
      decoration: BoxDecoration(
        color: (!error)
            ? color ?? kPrimaryLightColor
            : Colors.redAccent.withAlpha(40),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
