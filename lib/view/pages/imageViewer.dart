import 'package:clothes_demo_app/control/navigator_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageViewer extends StatelessWidget {
  ImageProvider image;
  int color;

  ImageViewer(this.image, this.color);

  NavigatorProvider nav;

  @override
  Widget build(BuildContext context) {
    nav = Provider.of<NavigatorProvider>(context);

    var imageView = Hero(
      tag: "ahmed",
      child: GestureDetector(
        onVerticalDragEnd: (de) {
          print(de.velocity.pixelsPerSecond);
          if (de.velocity.pixelsPerSecond.dy.abs() >
              de.velocity.pixelsPerSecond.dx.abs()) {
            Navigator.pop(context);
            nav.changeImageOpenState();
          }
        },
        child: Container(
          color: Color(color),
          child: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.fitHeight, image: image),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        right: 5,
                        top: 10,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            nav.changeImageOpenState();
                          },
                          icon: Icon(Icons.close),
                        )),
                  ],
                )),
          ),
        ),
      ),
    );
    return WillPopScope(
      onWillPop: onBackPressed,
      child: imageView,
    );
  }

  Future<bool> onBackPressed() async {
    nav.changeImageOpenState();
    return true;
  }
}
