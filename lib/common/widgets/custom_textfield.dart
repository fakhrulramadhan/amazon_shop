import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //padding: const EdgeInsets.only(top: 10),
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45)),
          hintText: hintText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter Your $hintText";
        }
        return null;
      },
    );
  }
}
