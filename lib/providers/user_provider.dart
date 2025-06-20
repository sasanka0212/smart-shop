import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
  );

  // use a getter method to access the private variable
  User get user => _user;

  void setuser(String user) {
    _user = User.fromJson(user);
    // notify about user value change
    notifyListeners();
  }
}