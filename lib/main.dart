import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vinsartisanmarket/Auth/Auth.dart';
import 'package:vinsartisanmarket/Models/AuthUser.dart';
import 'package:vinsartisanmarket/Models/HttpClient.dart';
import 'package:vinsartisanmarket/Views/Layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await checkAuth();
  runApp(const VAM());
}

Future checkAuth() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  Map<String,dynamic> user = jsonDecode(prefs.getString('user') ?? '{}');

  if (token.isEmpty) {
    isLoggedIn = false;
  } else {
    httpClient.setToken(token);
    Map res = await httpClient.authCheck();

    if (kDebugMode) {
      print(res);
    }
    if (res['code'] == 401) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
      httpClient.setToken(token);
      authUser.setUser(user);
    }
  }
}

class VAM extends StatelessWidget {
  const VAM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VinS Artisan Market',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      home: isLoggedIn ? const Layout() : const Auth(),
    );
  }
}
