import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      //utk menulis role usernya
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: '',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                const TextSpan(
                    text: 'Hello ',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                    )),
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
