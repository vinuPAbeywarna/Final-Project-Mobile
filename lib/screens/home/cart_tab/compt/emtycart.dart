import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';
import 'package:line_icons/line_icons.dart';

class Emptycart extends StatelessWidget {
  const Emptycart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kprimaryColor,
        title: Center(
            child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [const Icon(LineIcons.shoppingCart), const Text("Cart")],
          mainAxisAlignment: MainAxisAlignment.center,
        )),
      ),
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: size.height * 0.02, left: size.width * 0.035),
              child: Text(
                "Your cart is empty..",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              child: Lottie.asset("assets/animation/emptycart.json",
                  width: size.width * 0.6),
            )
          ],
        ),
      ),
    );
  }
}
