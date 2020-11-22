import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothes_demo_app/control/navigator_provider.dart';
import 'package:clothes_demo_app/control/user_provider.dart';
import 'package:clothes_demo_app/view/pages/chickout_home.dart';
import 'package:clothes_demo_app/view/value/color.dart';
import 'package:clothes_demo_app/view/value/dimon.dart';
import 'package:clothes_demo_app/view/value/fonts.dart';
import 'package:clothes_demo_app/view/value/image_path.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    NavigatorProvider nav = Provider.of<NavigatorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Shopping Cart", style: MyStyle.onSecondaryBig),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: user.getBasketProductList().isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagePath.emptyCartIcon2,
                        width: MyDemon.width(context) * .7,
                        height: MyDemon.width(context) * .5,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Empty Cart",
                          style: MyStyle.onBackGroundBig
                              .copyWith(fontFamily: Fonts.Poppins),
                        ),
                      ),
                      RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            MyDemon.width(context) * .15,
                          ),
                        ),
                        constraints: BoxConstraints(
                          minHeight: MyDemon.width(context) * .15,
                          minWidth: MyDemon.width(context) * .8,
                        ),
                        fillColor: MyColors.primary,
                        child: Text(
                          "Browse More",
                          style: MyStyle.onSecondary.copyWith(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          nav.changePage(0);
                        },
                      ),
                    ],
                  ))
                : ListView.separated(
                    itemCount: user.getBasketProductList().length + 1,
                    separatorBuilder: (c, i) => Divider(
                      height: 20,
                    ),
                    itemBuilder: (c, i) {
                      if (i < user.getBasketProductList().length) {
                        var basketProduct = user.getBasketProductList()[i];
                        return Container(
                          height: 130,
                          width: MyDemon.width(context),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: basketProduct
                                    .product.image.values.first.imageUrl,
                                imageBuilder: (c, i) => Container(
                                  height: 130,
                                  width: 100,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Color(basketProduct.product.image
                                          .values.first.imageColor),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(image: i)),
                                ),
                                progressIndicatorBuilder: (c, s, i) =>
                                    Container(
                                  height: 40,
                                  width: 40,
                                  color: Color(basketProduct
                                      .product.image.values.first.imageColor),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(basketProduct.productName,
                                        style: MyStyle.onBackGround
                                            .copyWith(fontSize: 18)),
                                    Row(
                                      children: [
                                        Text(
                                          "Color: ",
                                          style: MyStyle.onBackGround
                                              .copyWith(fontSize: 18),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: Color(
                                                basketProduct.productColor),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          "Size: ",
                                          style: MyStyle.onBackGround
                                              .copyWith(fontSize: 18),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            basketProduct.productSize
                                                .toUpperCase(),
                                            style: MyStyle.onBackGround
                                                .copyWith(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                        (basketProduct.product.price *
                                                    basketProduct
                                                        .productQuantity)
                                                .toString() +
                                            " EGP",
                                        style: MyStyle.onBackGround
                                            .copyWith(fontSize: 22))
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  RawMaterialButton(
                                    onPressed: () {
                                      user.setToBasket(basketProduct);
                                    },
                                    fillColor: MyColors.primary,
                                    constraints: BoxConstraints(
                                        minHeight: 35, minWidth: 35),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    basketProduct.productQuantity.toString(),
                                    style: MyStyle.onBackGround,
                                  ),
                                  RawMaterialButton(
                                    onPressed: () {
                                      user.removeFromBasket(basketProduct);
                                    },
                                    fillColor: MyColors.secondary,
                                    constraints: BoxConstraints(
                                        minHeight: 35, minWidth: 35),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 50,
                        );
                      }
                    },
                  ),
          ),
          user.getBasketProductList().isNotEmpty
              ? Positioned(
                  bottom: 10,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => CheckOutHome(),
                          ));
                    },
                    fillColor: MyColors.primary,
                    constraints: BoxConstraints(
                        minWidth: MyDemon.width(context) * .8, minHeight: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "Check Out",
                      style: MyStyle.onSecondaryBig,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
