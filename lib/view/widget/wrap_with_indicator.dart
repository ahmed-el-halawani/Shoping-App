import 'package:flutter/material.dart';

class WrapWithIndicator extends StatelessWidget {
  final Widget child;
  final bool indecatorState;

  WrapWithIndicator({this.child, this.indecatorState});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        (indecatorState)
            ? Container(
                color: Colors.black.withAlpha(40),
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(),
      ],
    );
  }
}
