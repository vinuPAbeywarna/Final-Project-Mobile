import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthUser {
  late int id;
  late String email;
  late String role;
  late Map user;

  AuthUser();

  void setUser(Map<String,dynamic> user) {
    id = user['id'];
    email = user['email'];
    role = user['role'];
    this.user = user;
  }

  Future<bool> saveUser(Map<String,dynamic> user) async{
    setUser(user);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user));
    return true;
  }
}

AuthUser authUser = AuthUser();
