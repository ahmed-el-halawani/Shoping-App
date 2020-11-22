import 'package:clothes_demo_app/control/user_provider.dart';
import 'package:clothes_demo_app/view/pages/register_screen.dart';
import 'package:clothes_demo_app/view/value/color.dart';
import 'package:clothes_demo_app/view/value/dimon.dart';
import 'package:clothes_demo_app/view/value/fonts.dart';
import 'package:clothes_demo_app/view/value/style.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class AdminHome extends StatelessWidget {
  const AdminHome();

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Profile", style: MyStyle.onSecondaryBig),
      ),
      body: user.isLogin()
          ? Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.getUser().username,
                            style: MyStyle.onBackGround.copyWith(
                              fontSize: 24,
                              fontFamily: Fonts.openSans,
                            )),
                        Text(user.getUser().userEmail,
                            style: MyStyle.onBackGround.copyWith(
                              fontSize: 18,
                              fontFamily: Fonts.openSans,
                            )),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: RawMaterialButton(
                      fillColor: MyColors.secondary,
                      onPressed: () {
                        user.logOutUser();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                        MyDemon.width(context) * .13,
                      )),
                      constraints: BoxConstraints(
                        minWidth: MyDemon.width(context) * .6,
                        minHeight: MyDemon.width(context) * .13,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          Text(
                            "log out",
                            style: MyStyle.onSecondary,
                          )
                        ],
                      )),
                )
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    fillColor: MyColors.primary,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => LoginScreen(),
                          ));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                      MyDemon.width(context) * .13,
                    )),
                    constraints: BoxConstraints(
                      minWidth: MyDemon.width(context) * .6,
                      maxWidth: MyDemon.width(context) * .6,
                      minHeight: MyDemon.width(context) * .13,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "log in",
                          style: MyStyle.onSecondary
                              .copyWith(fontFamily: Fonts.Poppins),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RawMaterialButton(
                    fillColor: MyColors.secondary,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => RegisterScreen(),
                          ));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                      MyDemon.width(context) * .13,
                    )),
                    constraints: BoxConstraints(
                      minWidth: MyDemon.width(context) * .6,
                      maxWidth: MyDemon.width(context) * .6,
                      minHeight: MyDemon.width(context) * .13,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Create New",
                          style: MyStyle.onSecondary
                              .copyWith(fontFamily: Fonts.Poppins),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
