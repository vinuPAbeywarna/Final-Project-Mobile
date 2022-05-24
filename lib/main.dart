import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vinsartisanmarket/Models/AuthUser.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinsartisanmarket/screens/auth/signin.dart';
import 'package:vinsartisanmarket/screens/home/home_screen.dart';
import 'package:vinsartisanmarket/screens/introduction/indroductionscreen.dart';
import 'package:vinsartisanmarket/screens/layout.dart';
import 'package:vinsartisanmarket/screens/welcome_screen/welcome_screen.dart';
import 'package:vinsartisanmarket/service/authentication/auth.dart';
import 'package:vinsartisanmarket/service/http_handeler/httpClient.dart';
import 'package:vinsartisanmarket/test/testscreen.dart';

bool isLoggedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkAuth();
  runApp(const VAM());
}

Future checkAuth() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  Map<String, dynamic> user = jsonDecode(prefs.getString('user') ?? '{}');
  // print("ok1");
  if (token.isEmpty) {
    isLoggedIn = false;
    nextscreen = const IntroDuctionPage(screen: Signin());
    // print("ok2");
  } else {
    httpClient.setToken(token);
    Map res = await httpClient.authCheck();

    if (kDebugMode) {
      print(res);
    }
    if (res['code'] == 401) {
      print("notlog");
      isLoggedIn = false;
      nextscreen = const IntroDuctionPage(screen: Signin());
    } else {
      print("log");
      isLoggedIn = true;
      httpClient.setToken(token);
      authUser.setUser(user);
      nextscreen = const HomeScreen();
    }
  }
}

Widget nextscreen = const IntroDuctionPage(screen: Signin());

class VAM extends StatelessWidget {
  const VAM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VinS Artisan Market',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      home: WelcomeScreen(
        nextscreen: nextscreen,
      ), // const Testscreen1()
      // home: isLoggedIn ? const Layout() : const Auth(),
    );
  }
}
