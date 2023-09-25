import 'package:amazon_shop/data/model/user.dart';
import 'package:flutter/material.dart';

//changenotifier larema doma,os
//changenotifier berfungsi utk menampung data model dinamis
class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  //buat getter
  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    //update UI
    notifyListeners(); //seperti update kalau setstate, emit di bloc
  }

  void setUserFromModel(User user) {
    _user = user; //_user diisi oleh UserModel

    notifyListeners(); //update UI
  }
}
