import 'package:amazon_shop/common/widgets/loader.dart';
import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/data/model/product.dart';
import 'package:amazon_shop/data/services/search_service.dart';
import 'package:amazon_shop/features/home/screens/widgets/address_box.dart';
import 'package:amazon_shop/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_shop/features/search/widget/searched_product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search";
  final String searchQuery; //dijadiin arguments
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products; // ? belum tentu ada, produk lebih dari 1
  SearchService searchService = SearchService();
  @override
  void initState() {
    super.initState();
    getSearchedProduct();
  }

  void getSearchedProduct() async {
    products = await searchService.getSearchProduct(
        context: context, searchQuery: widget.searchQuery);

    setState(() {}); //update UI
  }

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
        body: products == null
            ? const Loader()
            : Column(
                children: [
                  const AddressBox(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products!.length,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ProductDetailsScreen.routeName,
                                  arguments: products![index]);
                            },
                            child: SearchedProduct(product: products![index]));
                      },
                    ),
                  )
                ],
              ));
  }
}
