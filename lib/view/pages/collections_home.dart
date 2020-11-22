import 'package:clothes_demo_app/view/widget/grid_view.dart';
import 'package:clothes_demo_app/view/widget/slide_show.dart';
import 'package:clothes_demo_app/view/widget/switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionHome extends StatefulWidget {
  @override
  _CollectionHomeState createState() => _CollectionHomeState();
}

class _CollectionHomeState extends State<CollectionHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Image.asset("assets/image/logo.webp"),
      ),
      body: GridView2(
        firstItem: SliderShow2(),
        secondItem: Switcher(),
      ),
    );
  }

}
