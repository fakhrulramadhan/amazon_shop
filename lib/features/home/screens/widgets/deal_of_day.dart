import 'package:amazon_shop/common/widgets/loader.dart';
import 'package:amazon_shop/data/model/product.dart';
import 'package:amazon_shop/data/services/home_service.dart';
import 'package:amazon_shop/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;

  final HomeService homeService = HomeService();

  //meload pertama kali
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchDeaOfDay();
  }

  Future<Product?> fetchDeaOfDay() async {
    product = await homeService.fetchDealOfDay(context: context);

    return product;
  }

  void navigateToDetailScreen() async {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product //menampilkan detail wajib bawa argumentsnya
        );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? Container()
            : GestureDetector(
                onTap: () {
                  navigateToDetailScreen();
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        "Deal Of The Day",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    //menampilkan gambar pertama (index ke 0)
                    Image.network(
                      product!.images[0],
                      height: 220.0,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "\$90",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Fauull",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // menampilkan gambar (produk) lainnya disini
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //tipe map e nya harus berupa list widget
                          children: product!.images
                              .map(
                                (e) => Image.network(
                                  e,
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              )
                              .toList()),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      child: const Text(
                        "See all deals",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.cyan,
                        ),
                      ),
                    )
                  ],
                ),
              );
  }
}
