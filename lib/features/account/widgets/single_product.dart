import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: DecoratedBox(
        decoration: BoxDecoration(
            //kasih border
            border: Border.all(color: Colors.black12, width: 1.7),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          child: Image.network(
            image,
            width: 100.0,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
