import 'package:amazon_shop/data/model/user_model.dart';
import 'package:flutter/material.dart';

//changenotifier larema doma,os
class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '');

  //buat getter
  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    //update UI
    notifyListeners(); //seperti update kalau setstate, emit di bloc
  }
}
