import 'dart:convert';

import 'package:amazon_shop/constants/error_handling.dart';
import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/constants/utils.dart';
import 'package:amazon_shop/data/model/product.dart';
import 'package:amazon_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<List<Product>> getCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    //tipenya harus sama dengan tipe fungsinya (future...)
    List<Product> productList = []; //utk menampung data product
    try {
      http.Response res = await http.get(
          Uri.parse(
              "${GlobalVariables.baseUrl}/api/products?category=$category"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.token //butuh token
          });

      //on successnya meoad data produk ke admin
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            // isi data productlist dengan json model Produk
            //harus di encode dulu, karena tipenya harus string
            //kalau decode, tipenya dinamis
            //[i] nya ditaruh diluar  kurung body
            productList.add(Product.fromJson(jsonEncode(
              jsonDecode(res.body)[i],
            )));
          }
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
