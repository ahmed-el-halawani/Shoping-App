import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothes_demo_app/control/navigator_provider.dart';
import 'package:clothes_demo_app/control/user_provider.dart';
import 'package:clothes_demo_app/model/image.dart';
import 'package:clothes_demo_app/view/value/color.dart';
import 'package:clothes_demo_app/view/value/dimon.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'imageViewer.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  ProductDetails(this.product);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int imageIndex = 0;
  int sizeIndex = 0;
  String size;
  int color;

  @override
  Widget build(BuildContext context) {
    NavigatorProvider nav = Provider.of<NavigatorProvider>(context);
    UserProvider user = Provider.of<UserProvider>(context);
    var productImage = widget.product.image.values.toList()[imageIndex];
    color = productImage.color.colorHex;
    size = widget.product.size[sizeIndex];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          user.setToBasket(Basket(
              productName: widget.product.productName,
              productColor: color,
              productSize: size));
          print(user.getBasketProductList().length);
        },
        backgroundColor: MyColors.primary,
        child: Icon(Icons.add_shopping_cart_outlined),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            collapsedHeight: 40,
            toolbarHeight: 38,
            backgroundColor: Color(productImage.imageColor),
            iconTheme: MyStyle.iconThemeonSecondary,
            leading: IconButton(
              splashRadius: 20,
              icon: Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                splashRadius: 20,
                icon: user.isLikedProduct(widget.product.productName)
                    ? Icon(
                        Icons.favorite,
                        color: MyColors.primary,
                      )
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  user.setToFavorit(widget.product.productName);
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  color: Colors.white,
                ),
                height: 20,
                width: MyDemon.width(context),
              ),
            ),
            expandedHeight: MyDemon.height(context) * .5,
            flexibleSpace: FlexibleSpaceBar(
                title: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 2,
                                spreadRadius: 0,
                              )
                            ],
                            color: Colors.black,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 15,
                              spreadRadius: 0,
                            )
                          ],
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                background: SafeArea(
                  child: Hero(
                    tag: "ahmed",
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CachedNetworkImage(
                        imageUrl: productImage.imageUrl,
                        imageBuilder: (c, i) {
                          return GestureDetector(
                            onVerticalDragEnd: (de) {
                              print(de.velocity.pixelsPerSecond);
                              if (de.velocity.pixelsPerSecond.dy.abs() >
                                      de.velocity.pixelsPerSecond.dx.abs() &&
                                  de.velocity.pixelsPerSecond.dy > 0) {
                                nav.changeImageOpenState();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) =>
                                        ImageViewer(i, productImage.imageColor),
                                  ),
                                );
                              }
                            },
                            onTap: () {
                              nav.changeImageOpenState();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => ImageViewer(
                                          i, productImage.imageColor)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fitHeight, image: i)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )),
            pinned: true,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MyDemon.width(context) * .06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MyDemon.width(context) * .65,
                          child: Text(
                            widget.product.productName,
                            style: MyStyle.onBackGround,
                          ),
                        ),
                        Container(
                          width: MyDemon.width(context) * .2,
                          child: Text(widget.product.price.toString() + " EGP",
                              style: MyStyle.onBackGround
                                  .copyWith(fontWeight: FontWeight.w900)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Color",
                      style: MyStyle.onBackGround,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MyDemon.width(context) * .7,
                      height: 35,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product.image.values.length,
                        itemBuilder: (c, i) {
                          var image = widget.product.image.values.toList()[i];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                imageIndex = i;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: imageIndex == i
                                        ? Colors.black
                                        : Colors.white,
                                    width: 2),
                                color: Color(image.color.colorHex),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: 35,
                              height: 35,
                            ),
                          );
                        },
                        separatorBuilder: (c, i) => SizedBox(
                          width: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Size",
                      style: MyStyle.onBackGround,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MyDemon.width(context) * .7,
                      height: 35,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product.size.length,
                        itemBuilder: (c, i) {
                          var size = widget.product.size[i];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                sizeIndex = i;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: sizeIndex == i
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: 35,
                              height: 35,
                              child: Text(
                                size.toUpperCase(),
                                style: MyStyle.onBackGround.copyWith(
                                    color: sizeIndex == i
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (c, i) => SizedBox(
                          width: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
