import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clothes_demo_app/control/animation_provider.dart';
import 'package:clothes_demo_app/control/navigator_provider.dart';
import 'package:clothes_demo_app/model/slider.dart';
import 'package:clothes_demo_app/view/value/dimon.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderShow2 extends StatefulWidget {
  const SliderShow2();

  @override
  _SliderShow2State createState() => _SliderShow2State();
}

class _SliderShow2State extends State<SliderShow2>
    with TickerProviderStateMixin {
  AnimationController animCont;
  Animation anim;

  StreamSubscription s;

  bool isSliding = false;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    animCont =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    anim = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: animCont, curve: Curves.ease));
    animCont.forward();
  }

  @override
  Widget build(BuildContext context) {
    AnimationProvider animProv = Provider.of<AnimationProvider>(context);
    NavigatorProvider nav = Provider.of<NavigatorProvider>(context);
    if (nav.stack.isNotEmpty) {
      this.deactivate();
    }

    List<Widget> items = List.generate(sliderList.length, (index) {
      var slide = sliderList[index];
      var image = slide.image;
      var title = slide.title;

      return Container(
        margin: EdgeInsets.only(top: 5),
        height: 200,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(image.imageColor),
        ),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: image.imageUrl,
              imageBuilder: (c, i) {
                return Container(
                  decoration: BoxDecoration(
                      color: Color(image.imageColor),
                      image: DecorationImage(
                        image: i,
                      )),
                );
              },
              progressIndicatorBuilder: (c, s, d) {
                return Container(
                  color: Color(image.imageColor),
                );
              },
            ),
            Positioned(
              bottom: 10,
              child: AnimatedBuilder(
                animation: anim,
                builder: (c, w) => Opacity(
                    opacity: animCont.value,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, bottom: 10),
                      width: MyDemon.width(context) * .65,
                      child: Text(
                        title,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: MyStyle.onPrimaryTextStyle,
                      ),
                    )),
              ),
            )
          ],
        ),
      );
    });

    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: 170,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        onScrolled: (i) {
          if (animProv.isSliderScrolling == false) {
            animProv.setIsSliderScrolling(true);
            animCont.value = 0;
          }

          if (s != null) s.cancel();

          s = Stream.fromFuture(Future.delayed(Duration(milliseconds: 400)))
              .listen((event) {
            animProv.setIsSliderScrolling(false);
            animCont.reset();
            animCont.forward();
          });
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  @override
  void dispose() {
    if (s != null) s.cancel();
    animCont.dispose();
    super.dispose();
  }
}
