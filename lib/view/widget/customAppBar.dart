import 'package:clothes_demo_app/view/value/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends AppBar {
  final String label;
  final Function onBack;

  CustomAppBar({Key key, @required this.label, this.onBack})
      : super(
            key: key,
            backgroundColor: Colors.white,
            iconTheme: MyStyle.iconThemeOnSurface,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: onBack,
              icon: Icon(Icons.arrow_back_ios_outlined),
            ),
            title: Text(
              label,
              style: MyStyle.onBackGroundBig,
            ),
            brightness: Brightness.light);
}
