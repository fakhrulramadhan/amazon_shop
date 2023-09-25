import 'package:amazon_shop/common/widgets/custom_button.dart';
import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/features/address/screens/address_screen.dart';
import 'package:amazon_shop/features/cart/widgets/cart_product.dart';
import 'package:amazon_shop/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_shop/features/home/screens/widgets/address_box.dart';
import 'package:amazon_shop/features/search/screens/search_screen.dart';
import 'package:amazon_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddressScreen() {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
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
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: "Proceed To Checkout (${user.cart.length}) items",
                onTap: () {
                  navigateToAddressScreen();
                },
                color: Colors.yellow,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            //bikin garis
            Container(
              color: Colors.black12.withOpacity(0.09),
              height: 1,
            ),
            const SizedBox(
              height: 5.0,
            ),
            ListView.builder(
              itemCount: user.cart.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
