import 'package:amazon_shop/data/model/product.dart';
import 'package:amazon_shop/data/services/home_service.dart';
import 'package:flutter/material.dart';

import 'package:amazon_shop/constants/global_variables.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = "/category-deals";
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;

  final HomeService homeService = HomeService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gainCategoryProducts();
  }

  //HomeService().get......()
  gainCategoryProducts() async {
    await homeService.getCategoryProducts(
        context: context, category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60), //tingginya 52
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Text(
              widget.category,
              style: const TextStyle(
                fontSize: 17.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              alignment: Alignment.topLeft,
              child: Text(
                "Keep shopping for ${widget.category}",
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 180,
              child: GridView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.4),
                itemBuilder: (context, index) {
                  return const Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
