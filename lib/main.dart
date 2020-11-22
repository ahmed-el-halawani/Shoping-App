import 'package:clothes_demo_app/control/designProvider.dart';
import 'package:clothes_demo_app/control/user_provider.dart';
import 'package:clothes_demo_app/view/pages/home.dart';
import 'package:clothes_demo_app/view/pages/place_holder.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:clothes_demo_app/view/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'control/animation_provider.dart';
import 'control/main_provider.dart';
import 'control/navigator_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DesignProvider>(
          create: (context) => DesignProvider(),
        ),
        ChangeNotifierProvider<NavigatorProvider>(
          create: (context) => NavigatorProvider(),
        ),
        ChangeNotifierProvider<MainProvider>(
          create: (context) => MainProvider(),
        ),
        ChangeNotifierProvider<AnimationProvider>(
          create: (context) => AnimationProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigatorProvider nav = Provider.of<NavigatorProvider>(context);

    return MaterialApp(
      builder: (c, w) {
        return Scaffold(
          body: w,
          bottomNavigationBar: nav.isImage
              ? Container(
                  height: 0,
                  width: 0,
                )
              : bottomNav2(),
        );
      },
      debugShowCheckedModeBanner: false,
      theme: MyStyle.mainTheme(),
      title: "demo",
      home: Home2(),
    );
  }
}
