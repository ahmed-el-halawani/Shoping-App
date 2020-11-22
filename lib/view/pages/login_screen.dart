import 'package:clothes_demo_app/control/user_provider.dart';
import 'package:clothes_demo_app/view/pages/register_screen.dart';
import 'package:clothes_demo_app/view/value/color.dart';
import 'package:clothes_demo_app/view/value/dimon.dart';
import 'package:clothes_demo_app/view/widget/register/components/already_have_an_account_acheck.dart';
import 'package:clothes_demo_app/view/widget/register/components/rounded_button.dart';
import 'package:clothes_demo_app/view/widget/register/components/rounded_input_field.dart';
import 'package:clothes_demo_app/view/widget/register/components/rounded_password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserProvider user;
  bool inCorrectEmail = false;
  String errorMassage = "";

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: MyColors.secondary),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "LOG IN",
          style: TextStyle(color: MyColors.loginPrimaryColor),
        ),
        backgroundColor: MyColors.backGroundColor,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inCorrectMassage(),
              RoundedInputField(
                controller: emailController,
                hintText: "enter your email",
                icon: Icons.email,
              ),
              RoundedPasswordField(
                controller: passwordController,
                hint: "Password",
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  _signIn();
                },
              ),
              RoundedButton(
                text: "test",
                press: () {
                  _test();
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RegisterScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container inCorrectMassage() {
    return (inCorrectEmail)
        ? Container(
            width: MyDemon.width(context) * .8,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.redAccent.withAlpha(35),
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(width: 1, color: Colors.black87.withAlpha(40))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(errorMassage),
                InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      setState(() {
                        inCorrectEmail = false;
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.black87,
                    ))
              ],
            ),
          )
        : Container();
  }

  _signIn() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    for (var i in usersList) {
      if (i.userEmail == email && i.password == password) {
        user.loginUser(i);
        Navigator.pop(context);
        return true;
      }
    }
    setState(() {
      inCorrectEmail = true;
      errorMassage = "email or password are rong";
    });
  }

  _test() {
    user.loginUser(usersList[0]);
    Navigator.pop(context);
  }

//  =>_login()
}
