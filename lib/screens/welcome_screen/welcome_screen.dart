import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:vinsartisanmarket/main.dart';
import 'package:vinsartisanmarket/screens/auth/signin.dart';
import 'package:vinsartisanmarket/screens/home/home_screen.dart';
import 'package:vinsartisanmarket/screens/introduction/indroductionscreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key, required this.nextscreen}) : super(key: key);

  final Widget nextscreen;

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  double total = 9500;
  int cartitemcount = 1;
  @override
  void initState() {
    super.initState();

    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);

    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => nextscreen));
  }

  initScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print("Start");
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.2,
          ),
          Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Image.asset("assets/icons/appLogo.png")),
          SizedBox(
            height: size.height * 0.2,
          ),
          Text(
            "Copyright 2021 © Vins Artisan Market",
            style: TextStyle(
              fontSize: size.width * 0.038,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ));
  }
}
