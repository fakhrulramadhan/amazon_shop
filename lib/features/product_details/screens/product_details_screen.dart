import 'package:amazon_shop/common/widgets/custom_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/data/model/product.dart';
import 'package:amazon_shop/features/search/screens/search_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = "/product-details";
  final Product product;
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    color: Colors.white,
                    height: 43,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        //ketika dienter, ke halaman navigatesearch
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  size: 24.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 1,
                              ),
                            ),
                            hintText: "Search Amazon In",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17.0,
                            )),
                      ),
                    )),
              ),
              Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(left: 10),
                child: const Icon(
                  Icons.mic,
                  size: 24.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //tampilin id produknya
                  Text(
                    "${widget.product.id}",
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            //menampilkan list gbr produk sepertli slider
            CarouselSlider(
                items: widget.product.images.map((i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(viewportFraction: 1, height: 300)),
            //garis
            Container(
              color: Colors.black12,
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                  text: TextSpan(
                      text: "Deal Price: ",
                      style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                        text: "\$${widget.product.price}",
                        style: const TextStyle(
                            fontSize: 16.0,
                            color: GlobalVariables.priceColor,
                            fontWeight: FontWeight.w600))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.description,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: "Buy Now",
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: "Add to Cart",
                color: Colors.yellow,
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.black12,
              height: 4,
            ),
            const Padding(
              //kasih jarak kiri kanan 10
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Rate This Product",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
              initialRating: 0, //rating awal bintangnya 0
              minRating: 1,
              maxRating: 5,
              direction: Axis.horizontal, //bintangnya ada 5
              itemCount: 5,
              allowHalfRating: true, //ratingnya setengah
              //padding jarak antar bintang
              itemPadding: const EdgeInsets.symmetric(horizontal: 3),
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                size: 24.0,
                color: GlobalVariables.secondaryColor,
              ),
              //ketika rating bintangnya di hover
              onRatingUpdate: (value) {},
            )
          ],
        ),
      ),
    );
  }
}
