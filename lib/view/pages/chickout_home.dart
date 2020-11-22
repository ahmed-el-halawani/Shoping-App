import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothes_demo_app/control/user_provider.dart';
import 'package:clothes_demo_app/view/pages/login_screen.dart';
import 'package:clothes_demo_app/view/value/color.dart';
import 'package:clothes_demo_app/view/value/dimon.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:clothes_demo_app/view/widget/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class CheckOutHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, w) =>
          user.isLogin() ? ChickOutDetails() : LoginScreen(),
    );
  }
}

class ChickOutDetails extends StatefulWidget {
  @override
  _ChickOutDetailsState createState() => _ChickOutDetailsState();
}

class _ChickOutDetailsState extends State<ChickOutDetails> {
  UserProvider user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        label: "Check Out",
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: MyDemon.width(context) * .03),
        child: ListView(
          children: [
            Container(
              width: MyDemon.width(context),
              constraints: BoxConstraints(
                maxHeight: MyDemon.height(context) * .4,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: user.getBasketProductList().length,
                separatorBuilder: (c, i) => Divider(
                  height: 10,
                ),
                itemBuilder: (c, i) {
                  var basketProduct = user.getBasketProductList()[i];
                  return Container(
                    height: 70,
                    width: MyDemon.width(context),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              basketProduct.product.image.values.first.imageUrl,
                          imageBuilder: (c, i) => Container(
                            height: 70,
                            width: 70,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: Color(basketProduct
                                    .product.image.values.first.imageColor),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: i)),
                          ),
                          progressIndicatorBuilder: (c, s, i) => Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(basketProduct.productName,
                                  style: MyStyle.onBackGround
                                      .copyWith(fontSize: 15)),
                              Row(
                                children: [
                                  Text(
                                    "Color: ",
                                    style: MyStyle.onBackGround
                                        .copyWith(fontSize: 15),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Color(basketProduct.productColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    "Size: ",
                                    style: MyStyle.onBackGround
                                        .copyWith(fontSize: 15),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      basketProduct.productSize.toUpperCase(),
                                      style: MyStyle.onBackGround
                                          .copyWith(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                  (basketProduct.product.price *
                                              basketProduct.productQuantity)
                                          .toString() +
                                      " EGP",
                                  style: MyStyle.onBackGround
                                      .copyWith(fontSize: 15))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(
              height: 10,
            ),
            deliveryAddress1(),
            shipping(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: RawMaterialButton(
          onPressed: () {},
          fillColor: MyColors.secondary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Text(
            "Check Out",
            style: MyStyle.onSecondaryBig,
          ),
        ),
      ),
    );
  }

  deliveryAddress1() {
    return chickOutTile(
        title: "Delivery address",
        child: InkWell(
          onTap: () {
            _getMyLocationDialog();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    LineIcons.map_marker,
                    size: 35,
                    color: Colors.black87,
                  ),
                  Container(
                    width: MyDemon.width(context) * .6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.getLocationContry(),
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Text(
                          user.getLocationDetails(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.black87),
            ],
          ),
        ));
  }

  shipping() {
    return chickOutTile(
      title: "receipt",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "total quantity",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  user.getTotalQuantity().toString(),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "subtotal",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  user.getTotalPrice().toString(),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "shipping price",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  user.shappingPrice().toString(),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            Divider(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "total",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  (user.getTotalPrice() + user.shappingPrice()).toString(),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  chickOutTile({Widget child, String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
        ),
        Text(
          title.toUpperCase(),
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 1,
          color: Colors.black12,
        ),
        child,
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 1,
          color: Colors.black12,
        ),
      ],
    );
  }

  _getMyLocationDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: MyColors.backGroundColor,
            title: Container(
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black87,
                  ),
                ),
              ),
              child: Text(
                "Choose A Delivery Address",
                style: TextStyle(color: Colors.black38),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder(
                  future: getLocation(),
                  builder: (context, AsyncSnapshot<Address> a) {
                    return (a.hasData)
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                var cuntry = a.data.addressLine.split(",");
                                var c = cuntry[cuntry.length - 2];
                                print(c);
                                user.setLocation(
                                    lat: a.data.coordinates.latitude,
                                    long: a.data.coordinates.longitude,
                                    location: a.data.addressLine,
                                    country: c);
                                print(
                                    "${a.data.addressLine} : ${a.data.coordinates.latitude}:${a.data.coordinates.longitude}");
                              });
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.my_location,
                                        color: Colors.black87,
                                        size: 30,
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Current Location",
                                          style: MyStyle.onBackGroundRegular,
                                        ),
                                        ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    MyDemon.width(context) *
                                                        .5),
                                            child: Text(
                                              a.data.addressLine,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  MyStyle.onBackGroundRegular,
                                            ))
                                        // location after gelocator
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black87,
                                ),
                              ],
                            ))
                        : Container(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.of(context, rootNavigator: true).pop();
                        user.setLocation(
                            lat: 30.0131,
                            long: 31.2089,
                            location: "Giza, Giza District, Giza Governorate",
                            country: "Giza");
                      });
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.my_location,
                                color: Colors.black87,
                                size: 30,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Location",
                                  style: MyStyle.onBackGroundRegular,
                                ),
                                ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: MyDemon.width(context) * .5),
                                    child: Text(
                                      "Giza, Giza District, Giza Governorate",
                                      overflow: TextOverflow.ellipsis,
                                      style: MyStyle.onBackGroundRegular,
                                    ))
                                // location after gelocator
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black87,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.of(context, rootNavigator: true).pop();
                        user.setLocation(
                            lat: 31.2001,
                            long: 29.9187,
                            location:
                                "Bab Sharqi WA Wabour Al Meyah, Qism Bab Sharqi, Alexandria Governorate",
                            country: "Alexandria");
                      });
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.my_location,
                                color: Colors.black87,
                                size: 30,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Location",
                                  style: MyStyle.onBackGroundRegular,
                                ),
                                ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: MyDemon.width(context) * .5),
                                    child: Text(
                                      "Bab Sharqi WA Wabour Al Meyah, Qism Bab Sharqi, Alexandria Governorate",
                                      overflow: TextOverflow.ellipsis,
                                      style: MyStyle.onBackGroundRegular,
                                    ))
                                // location after gelocator
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black87,
                        ),
                      ],
                    )),
              ],
            ));
      },
    );
  }

  Future<Address> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    Address first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");

    return first;
  }
}
