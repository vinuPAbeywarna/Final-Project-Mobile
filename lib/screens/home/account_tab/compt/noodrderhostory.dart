import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Noorderhistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: size.height * 0.02, left: size.width * 0.035),
            child: Text(
              "No order history..",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            child: Lottie.asset("assets/animation/emptybox.json",
                width: size.width * 0.9),
          )
        ],
      ),
    );
  }
}
