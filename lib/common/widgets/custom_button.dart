import 'package:amazon_shop/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  String text;
  VoidCallback onTap;
  Color? color; //blm tentu diisi
  CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        backgroundColor: widget.color ?? GlobalVariables.secondaryColor,
      ),
      onPressed: widget.onTap,
      child: Text(
        widget.text, //cara manggil variabel di stateful
      ),
    );
  }
}
