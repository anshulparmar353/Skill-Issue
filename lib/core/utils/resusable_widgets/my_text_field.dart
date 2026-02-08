import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscure,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        enabledBorder: Theme.of(context).inputDecorationTheme.border,
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).primaryColor),
        // icon: Image.asset("assets/email-icon.png"),
      ),
    );
  }
}
