import 'package:doctorji/models/entity_model/user.dart';
import 'package:doctorji/resources/auth_methods.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User _user;
  AuthMethods _authMethods = AuthMethods();

  User get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

}