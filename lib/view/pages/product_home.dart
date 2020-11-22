import 'package:clothes_demo_app/control/designProvider.dart';
import 'package:clothes_demo_app/control/navigator_provider.dart';
import 'package:clothes_demo_app/model/image.dart';
import 'package:clothes_demo_app/view/value/custom_icon.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:clothes_demo_app/view/widget/customAppBar.dart';
import 'package:clothes_demo_app/view/widget/grid_view_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductHome extends StatelessWidget {
  final List<Product> products;
  final String collectionName;

  ProductHome(this.products, this.collectionName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: collectionName,
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: GridViewProduct(products: products),
    );
  }
}
