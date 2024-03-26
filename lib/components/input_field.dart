import 'package:flutter/material.dart';

import '../constants/constants.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      this.suffix,
      required this.controller,
      required this.isPassword,
      required this.labelText,
      required this.prefix});

  final TextEditingController controller;
  final bool isPassword;
  final String labelText;
  final IconData prefix;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(5.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        prefixIcon: Icon(prefix, color: primaryColor),
        filled: true,
        suffix: suffix,
        fillColor: primaryColor.withOpacity(0.2),
        labelText: labelText,
        labelStyle: TextStyle(color: primaryColor),
      ),
    );
  }
}
