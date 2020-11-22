import 'package:clothes_demo_app/control/main_provider.dart';
import 'package:clothes_demo_app/model/image.dart';
import 'package:clothes_demo_app/view/value/color.dart';
import 'package:clothes_demo_app/view/widget/grid_view_product.dart';
import 'package:clothes_demo_app/view/widget/register/components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchHome extends StatefulWidget {
  @override
  _SearchHomeState createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  int index = 3;
  List<Product> productList = [];

  @override
  Widget build(BuildContext context) {
    MainProvider mainP = Provider.of<MainProvider>(context);
    index++;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: RoundedInputField(
              textColor: Colors.white,
              color: MyColors.secondary,
              icon: Icons.search_outlined,
              onChanged: (s) {
                productList = mainP.getSearch(s);
              },
              hintText: "search for product",
            ),
          )),
      body: GridViewProduct(
        products: productList,
      ),
    );
  }
}
