import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothes_demo_app/control/designProvider.dart';
import 'package:clothes_demo_app/control/main_provider.dart';
import 'package:clothes_demo_app/control/navigator_provider.dart';
import 'package:clothes_demo_app/control/user_provider.dart';
import 'package:clothes_demo_app/model/image.dart';
import 'package:clothes_demo_app/view/pages/product_details_home.dart';
import 'package:clothes_demo_app/view/value/color.dart';
import 'package:clothes_demo_app/view/value/custom_icon.dart';
import 'package:clothes_demo_app/view/value/dimon.dart';
import 'package:clothes_demo_app/view/value/fonts.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:clothes_demo_app/view/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class GridViewProduct extends StatefulWidget {
  final List<Product> products;

  const GridViewProduct({this.products});

  @override
  _GridViewProductState createState() => _GridViewProductState();
}

class _GridViewProductState extends State<GridViewProduct> {
  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    DesignProvider des = Provider.of<DesignProvider>(context);
    NavigatorProvider nav = Provider.of<NavigatorProvider>(context);

    List<num> imageSizes = [3, 3.5, 4, 4.5];
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 40,
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IconButton(
                icon: Icon(
                  CutsomIcon.staggredgrid,
                ),
                alignment: Alignment.center,
                iconSize: 18,
                splashRadius: 20,
                color: des.viewChoiseIndex == ViewChoise.stagridGrid
                    ? Colors.red
                    : Colors.black54,
                onPressed: () {
                  des.changeViewChoise(ViewChoise.stagridGrid);
                },
              ),
              IconButton(
                icon: Icon(Icons.grid_view),
                iconSize: 25,
                color: des.viewChoiseIndex == ViewChoise.grid
                    ? Colors.red
                    : Colors.black54,
                splashRadius: 20,
                onPressed: () {
                  des.changeViewChoise(ViewChoise.grid);
                },
              ),
              IconButton(
                icon: Icon(Icons.crop_square),
                iconSize: 25,
                color: des.viewChoiseIndex == ViewChoise.list
                    ? Colors.red
                    : Colors.black54,
                splashRadius: 20,
                onPressed: () {
                  des.changeViewChoise(ViewChoise.list);
                  print("ahmed");
                },
              )
            ],
          ),
        ),
        Expanded(
          child: StaggeredGridView.countBuilder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            crossAxisCount: 4,
            itemCount: widget.products.length,
            itemBuilder: (BuildContext context, int index) {
              Product p = widget.products[index];
              ImageModel imageModel = p.image.values.toList().first;

              return InkWell(
                onTap: () {
                  nav.isBottomSheetOpened = true;
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_) => ProductDetails(p)));
                },
                child: Column(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: imageModel.imageUrl,
                        imageBuilder: (context, imageProvider) {
                          int colorInt = imageModel.imageColor;

                          return Container(
                            decoration: BoxDecoration(
                              color: Color(colorInt).computeLuminance() > 0.8
                                  ? HSVColor.fromColor(Color(colorInt))
                                      .withValue(.8)
                                      .toColor()
                                  : Color(colorInt),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 1, vertical: 1),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: imageProvider,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: InkWell(
                                    onTap: () {
                                      user.setToFavorit(p.productName);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white.withOpacity(.3),
                                      ),
                                      child: user.isLikedProduct(p.productName)
                                          ? Icon(
                                              Icons.favorite,
                                              color: MyColors.primary,
                                            )
                                          : Icon(Icons.favorite_border),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        progressIndicatorBuilder: (c, s, d) {
                          int colorInt = imageModel.imageColor;
                          return Container(
                            decoration: BoxDecoration(
                              color: Color(colorInt).computeLuminance() > 0.8
                                  ? HSVColor.fromColor(Color(colorInt))
                                      .withValue(.9)
                                      .toColor()
                                  : Color(colorInt),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5, left: 2),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              p.productName,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: MyStyle.onSurface.copyWith(fontSize: 16),
                            ),
                            Text(p.price.toString() + " EGP",
                                textAlign: TextAlign.left,
                                style: MyStyle.onSurface.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                )),
                          ]),
                    ),
                  ],
                ),
              );
            },
            staggeredTileBuilder: (int index) {
              switch (des.viewChoiseIndex) {
                case ViewChoise.stagridGrid:
                  return StaggeredTile.count(2, imageSizes[index % 4]);
                case ViewChoise.grid:
                  return StaggeredTile.count(2, 4);
                case ViewChoise.list:
                  return StaggeredTile.count(4, 5);
                default:
                  return StaggeredTile.count(2, imageSizes[index % 4]);
              }
            },
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        )
      ],
    );
  }
}
