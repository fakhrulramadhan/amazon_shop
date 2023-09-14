import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/features/home/screens/widgets/address_box.dart';
import 'package:amazon_shop/features/home/screens/widgets/carousel_image.dart';
import 'package:amazon_shop/features/home/screens/widgets/deal_of_day.dart';
import 'package:amazon_shop/features/home/screens/widgets/top_categories.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //cek data usernya yang login sudah ada atau belum
    //menangkap data user yang login

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
        body: const SingleChildScrollView(
          child: Column(
            children: [
              AddressBox(),
              SizedBox(
                height: 10.0,
              ),
              TopCategories(),
              SizedBox(
                height: 10.0,
              ),
              CarouselImage(),
              SizedBox(
                height: 10.0,
              ),
              DealOfDay(),
            ],
          ),
        ));
  }
}
