import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';
import 'fonts.dart';

class MyStyle {
  static ThemeData mainTheme() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return ThemeData.light().copyWith(
      appBarTheme: AppBarTheme().copyWith(
        color: MyColors.appbar,
        iconTheme: IconThemeData(color: Colors.white, size: 25),
      ),
      backgroundColor: MyColors.background,
      primaryIconTheme: IconThemeData(color: MyColors.onSurface),
      textTheme: TextTheme(
        bodyText2: TextStyle(color: MyColors.onSurface),
        bodyText1: TextStyle(color: MyColors.onBackGround),
      ),
    );
  }

  static TextStyle onPrimaryTextStyle = TextStyle(
      backgroundColor: MyColors.primary,
      color: MyColors.onPrimary,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static TextStyle onPrimaryTextStyleSmall = TextStyle(
    backgroundColor: MyColors.primary,
    color: MyColors.onPrimary,
    fontSize: 16,
  );

  static IconThemeData iconThemeOnSurface =
      IconThemeData(color: MyColors.onSurface);
  static IconThemeData iconThemeonSecondary =
      IconThemeData(color: MyColors.onSecondary);
  static TextStyle onSecondary =
      TextStyle(color: MyColors.onSecondary, fontSize: 20);
  static TextStyle onSecondaryBig = TextStyle(
      color: MyColors.onSecondary, fontFamily: Fonts.openSans, fontSize: 27);
  static TextStyle onBackGround = TextStyle(
      color: MyColors.onBackGround, fontFamily: Fonts.openSans, fontSize: 20);
  static TextStyle onBackGroundRegular =
      TextStyle(color: MyColors.onBackGround, fontSize: 18);
  static TextStyle onSurface = TextStyle(
      color: MyColors.onSurface, fontFamily: Fonts.openSans, fontSize: 20);
  static TextStyle onSurfaceBig = TextStyle(
      color: MyColors.onSurface, fontFamily: Fonts.openSans, fontSize: 27);
  static TextStyle onBackGroundBig = TextStyle(
      color: MyColors.onBackGround, fontFamily: Fonts.openSans, fontSize: 27);
}
