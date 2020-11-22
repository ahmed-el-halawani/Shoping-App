import 'package:clothes_demo_app/control/user_provider.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:clothes_demo_app/view/widget/grid_view_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikesHome extends StatelessWidget {
  const LikesHome();

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Wish List", style: MyStyle.onSecondaryBig),
      ),
      body: GridViewProduct(products: user.getFavoriteList()),
    );
  }
}
