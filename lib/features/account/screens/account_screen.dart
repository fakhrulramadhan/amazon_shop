import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/features/account/widgets/below_app_bar.dart';
import 'package:amazon_shop/features/account/widgets/orders_widget.dart';
import 'package:amazon_shop/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(52), //tingginya 52
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/images/amazon_in.png",
                    width: 120.0,
                    height: 45.0,
                    //fit: BoxFit.fill,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.notifications_outlined,
                          size: 24.0,
                        ),
                      ),
                      Icon(
                        Icons.search,
                        size: 24.0,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BelowAppBar(),
            SizedBox(
              height: 10.0,
            ),
            TopButtons(),
            SizedBox(
              height: 20.0,
            ),
            OrdersWidget()
          ],
        ));
  }
}
