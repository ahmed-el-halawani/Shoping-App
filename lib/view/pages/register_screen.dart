import 'package:clothes_demo_app/control/user_provider.dart';
import 'package:clothes_demo_app/view/value/color.dart';
import 'package:clothes_demo_app/view/value/dimon.dart';
import 'package:clothes_demo_app/view/widget/register/components/already_have_an_account_acheck.dart';
import 'package:clothes_demo_app/view/widget/register/components/rounded_button.dart';
import 'package:clothes_demo_app/view/widget/register/components/rounded_input_field.dart';
import 'package:clothes_demo_app/view/widget/register/components/rounded_password_field.dart';
import 'package:clothes_demo_app/view/widget/wrap_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Field {
  String fName;
  bool fErrorState;
  String fHint;
  String fType;
  TextEditingController fController = TextEditingController();

  Field(this.fName, this.fErrorState, this.fHint, this.fType);
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  UserProvider user;

  List<String> errorFailds = [];
  List<TextEditingController> textEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  List<Field> listOfFields = [
    Field("name", false, "Name", "text"),
    Field("email", false, "Email", "text"),
    Field("Phone Number", false, "Phone Number", "text"),
    Field("password", false, "password", "password"),
    Field("confPassword", false, "Confirm password", "password")
  ];

  bool submit = false;
  bool displayErrorMassage = false;
  String inCorrectMassage = "";
  bool showIndicator = false;

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
          "SIGN UP",
          style: TextStyle(color: MyColors.loginPrimaryColor),
        ),
        backgroundColor: MyColors.backGroundColor,
      ),
      body: WrapWithIndicator(
        indecatorState: showIndicator,
        child: registerForm2(context),
      ),
    );
  }

  bool isThereError(Field f) {
    return (f.fErrorState || f.fController.text.isEmpty && submit);
  }

  /// widgets /////////
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        "SIGN UP",
        style: TextStyle(color: MyColors.loginPrimaryColor),
      ),
      backgroundColor: MyColors.backGroundColor,
    );
  }

  Container registerForm2(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        children: [
          inCorrectFieldMassage(),
          ...List.generate(listOfFields.length, (index) {
            Field field = listOfFields[index];
            return (field.fType == "text")
                ? RoundedInputField(
                    controller: field.fController,
                    error: isThereError(field),
                    hintText: field.fHint,
                    onChanged: (value) {
                      setState(() {});
                    },
                  )
                : RoundedPasswordField(
                    controller: field.fController,
                    error: isThereError(field),
                    onChanged: (value) {
                      setState(() {});
                    },
                    hint: field.fHint,
                  );
          }),
          RoundedButton(
            text: "SIGN UP",
            press: () {
              submit = true;
              setState(() {
                showIndicator = true;
              });
              _signUp2();
            },
          ),
          SizedBox(height: MyDemon.height(context) * 0.03),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Container inCorrectFieldMassage() {
    return (displayErrorMassage)
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
                Container(
                  width: MyDemon.width(context) * .75,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(inCorrectMassage),
                  ),
                ),
                InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      setState(() {
                        displayErrorMassage = false;
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

  /// functions /////
  isEmpty(String field) {
    if (field.isEmpty && submit) {
      return true;
    }
    return false;
  }

  _signUp2() {
    for (Field i in listOfFields) {
      if (i.fController.text.isEmpty) {
        showIndicator = false;
        return;
      }
    }

    if (listOfFields[3].fController.text != listOfFields[4].fController.text) {
      errorFailds.add("value");
      showIndicator = false;
      setState(() {
        displayErrorMassage = true;
        inCorrectMassage = "password and confirm password mismatch";
      });
    } else {
      user.logupUser(UserLogIn(
        username: listOfFields[0].fController.text,
        userEmail: listOfFields[1].fController.text,
        userNumber: listOfFields[2].fController.text,
        password: listOfFields[3].fController.text,
      ));
      Navigator.pop(context);
    }
  }
}
