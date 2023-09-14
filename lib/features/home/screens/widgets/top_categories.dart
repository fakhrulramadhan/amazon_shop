import 'package:amazon_shop/constants/global_variables.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemExtent: 75, //jarak antar icon
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  child: Image.asset(
                    GlobalVariables.categoryImages[index]['image']!,
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "${GlobalVariables.categoryImages[index]['title']}",
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
