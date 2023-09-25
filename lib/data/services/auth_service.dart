import 'dart:convert';

import 'package:amazon_shop/common/widgets/bottom_bar.dart';
import 'package:amazon_shop/constants/error_handling.dart';
import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/constants/utils.dart';
import 'package:amazon_shop/data/model/user.dart';
import 'package:amazon_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //sign up user
  void signUpUser(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      //butuh user utk tambah data
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [], //cart kasih list kosong aja
      );

      http.Response res =
          await http.post(Uri.parse("${GlobalVariables.baseUrl}/api/signup"),
              body: user.toJson(), //body utk isian datanya, konvert ke json
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, "Success Created: Login with the same credentials ");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //sign up user
  void signInUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      http.Response res = await http.post(
          Uri.parse("${GlobalVariables.baseUrl}/api/signin"),
          body: jsonEncode({
            'email': email,
            'password': password
          }), //diencode kalau lgin, konvert ke json
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      print(res.body);

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          //init dulu
          SharedPreferences prefs = await SharedPreferences.getInstance();

          //kalyak blocprovider lagi,
          //disini proses login
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          //dapatin tokennya dan tulis tokennya ke local memori hp
          await prefs.setString(
              'x-auth-token', jsonDecode(res.body)['token']); //write data

          //akan ke halaman homsecreen dan tidak bisa di back (keremove)
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get user data
  void getUserData({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      //jika token enggak ada maka valu tokennya dikosongin ''
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      //buat dapatin token dari backend
      var tokenRes = await http.post(
          Uri.parse("${GlobalVariables.baseUrl}/tokenIsValid"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      //jika response = true, maka dapat data user
      if (response == true) {
        http.Response userRes = await http.get(
            Uri.parse('${GlobalVariables.baseUrl}/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
