import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinsartisanmarket/models/loggedUser.dart';

class UserHandeler {
  static Future<LoggedUserModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoggedUserModel user;
    user = LoggedUserModel.fromMap(jsonDecode(prefs.getString('user')!));
    return user;
  }
}
