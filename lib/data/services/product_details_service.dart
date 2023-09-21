import 'dart:convert';

import 'package:amazon_shop/constants/error_handling.dart';
import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/constants/utils.dart';
import 'package:amazon_shop/data/model/product.dart';
import 'package:amazon_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsService {
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      //nama preset, nama upload ke cloudinary.com

      //login user, tokennya wajib dimasukkin ke headers
      http.Response res = await http.post(
          Uri.parse("${GlobalVariables.baseUrl}/api/rate-product"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.token, //ambil token yang login
          },
          //field id dan rating diisi oleh required nama fieldnya
          body: jsonEncode({
            'id': product.id!,
            'rating': rating,
          }));

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Success Rate Product");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
