import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothes_demo_app/control/main_provider.dart';
import 'package:clothes_demo_app/control/navigator_provider.dart';
import 'package:clothes_demo_app/model/image.dart';
import 'package:clothes_demo_app/view/pages/product_home.dart';
import 'package:clothes_demo_app/view/value/fonts.dart';
import 'package:clothes_demo_app/view/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class GridView2 extends StatefulWidget {
  final Widget firstItem;
  final Widget secondItem;

  const GridView2({this.firstItem, this.secondItem});

  @override
  _GridView2State createState() => _GridView2State();
}

class _GridView2State extends State<GridView2> {
  @override
  Widget build(BuildContext context) {
    MainProvider prov = Provider.of<MainProvider>(context);
    NavigatorProvider nav = Provider.of<NavigatorProvider>(context);
    List<Collection> collection = prov.getCollection();
    List<num> imageSizes = [2.35, 3.25, 4];

    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      crossAxisCount: 4,
      itemCount: prov.collections.isNotEmpty ? prov.collections.length + 2 : 3,
      itemBuilder: (BuildContext context, int index) {
        var newIndex = index - 2;
        if (index - 2 >= 0) {
          if (prov.collections.isNotEmpty) {
            var imageModel = collection[newIndex].collectionImage;
            var collectionTitle = collection[newIndex].collectionName;
            var collectionProducts = collection[newIndex].collectionProduc;
            return InkWell(
              onTap: () {
                // nav.customPushStack(ProductHome(collectionProducts.values.toList(), collectionTitle));
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (c) => ProductHome(
                          collectionProducts.values.toList(), collectionTitle),
                    ));
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
                                    .withValue(.9)
                                    .toColor()
                                : Color(colorInt),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: Color(colorInt).computeLuminance() > 0.8
                              ? EdgeInsets.symmetric(horizontal: 3, vertical: 1)
                              : EdgeInsets.all(0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: imageProvider,
                              ),
                            ),
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
                    alignment: Alignment.center,
                    child: Text(
                      collectionTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: Fonts.openSans,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Loading2(prov.collections.isNotEmpty == true));
          }
        } else {
          return index - 2 == -2 ? widget.firstItem : widget.secondItem;
        }
      },
      staggeredTileBuilder: (int index) {
        return index - 2 < 0
            ? StaggeredTile.fit(4)
            : prov.collections.isNotEmpty
                ? new StaggeredTile.count(2, imageSizes[index % 3])
                : StaggeredTile.count(4, 3);
      },
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
