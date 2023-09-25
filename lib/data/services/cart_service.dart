import 'dart:convert';
import 'package:amazon_shop/constants/error_handling.dart';
import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/constants/utils.dart';
import 'package:amazon_shop/data/model/product.dart';
import 'package:amazon_shop/data/model/user.dart';
import 'package:amazon_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartService {
  void removeToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      //nama preset, nama upload ke cloudinary.com

      //login user, tokennya wajib dimasukkin ke headers
      //hapus id produknya di cart
      http.Response res = await http.delete(
        Uri.parse(
            "${GlobalVariables.baseUrl}/api/remove-from-cart/${product.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token, //ambil token yang login
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        //karena tipe data cartnya map, maka pakai fromMap
        onSuccess: () {
          //User.fromMap(jsonDecode(res.body));

          //tampung data dari produk yang ada di keranjang ke variabel user
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);

          //simpan data belanjaan (cart)
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
