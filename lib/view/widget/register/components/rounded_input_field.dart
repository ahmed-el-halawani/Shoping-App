import 'package:clothes_demo_app/view/widget/register/components/text_field_container.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool error;
  final String errorMassage;
  final TextEditingController controller;
  final Color color;
  final Color textColor;

  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.error = false,
      this.errorMassage = "",
      this.controller,
      this.color,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: color,
      error: error,
      child: TextField(
        controller: controller ?? null,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        style: TextStyle(
          fontSize: 20,
          color: textColor ?? kPrimaryColor,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: textColor ?? kPrimaryColor,
          ),
          hintText: (!error) ? hintText : "$hintText Not Valid",
          hintStyle: TextStyle(
            color: textColor ?? kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
