import 'dart:convert';
import 'dart:io';

import 'package:amazon_shop/constants/error_handling.dart';
import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/constants/utils.dart';
import 'package:amazon_shop/data/model/product.dart';
import 'package:amazon_shop/features/admin/screens/admin_screen.dart';
import 'package:amazon_shop/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  //no recommended save images to mongodb karena kapasistas di mongodb kecil
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      //nama preset, nama upload ke cloudinary.com
      final cloudinary = CloudinaryPublic('dca5cd7ax', 'ihiosdav');

      List<String> imageUrls = [];

      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse cloudres = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));

        imageUrls.add(cloudres.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls, //imageUrlnya ke cloudinary
          category: category,
          price: price);

      http.Response res = await http.post(
          Uri.parse("${GlobalVariables.baseUrl}/admin/add-product"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.token, //ambil token yang login
          },
          body: product.toJson());

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Success Add Product");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminScreen()),
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> getAllProducts(BuildContext context) async {
    //listen false agar tidak ada error inherited widget
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    //tipenya harus sama dengan tipe fungsinya (future...)
    List<Product> productList = []; //utk menampung data product
    try {
      http.Response res = await http.get(
          Uri.parse("${GlobalVariables.baseUrl}/admin/get-products"),
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
    return productList; //munculkan list product..,,
  }
}
