import 'package:amazon_shop/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//pakai package flutter_rating_bar
class Stars extends StatelessWidget {
  final double rating;
  const Stars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5, //5 bintang
      rating: rating,
      itemSize: 15,
      //indexnya enggak dipakai
      itemBuilder: (context, _) => const Icon(
        Icons.stars,
        size: 24.0,
        color: GlobalVariables.secondaryColor, //atau warna kuning
      ),
    );
  }
}
