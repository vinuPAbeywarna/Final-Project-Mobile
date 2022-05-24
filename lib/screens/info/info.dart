import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:vinsartisanmarket/components/customfloatingacyionbutton.dart';

class Infoscreen extends StatelessWidget {
  const Infoscreen({
    Key? key,
  }) : super(key: key);

  get kprimarylightcolor => null;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.withOpacity(0.1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: kprimarylightcolor,
      floatingActionButton: Floatingactmenu(size: size),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.indigo.withOpacity(0.1),
          ),
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "About Us",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: size.width * 0.07,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 0.08))),
                child: Image.asset("assets/images/infoaboutus.jpg"),
                width: size.width * 0.98,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                height: size.height * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: size.height * 0.01, left: size.width * 0.035),
                      child: Text(
                        "Online shopping is the activity or action of buying products or services over the Internet. It means going online, landing on a seller’s website, selecting something, and arranging for its delivery. The buyer either pays for the good or service online with a credit or debit card or upon delivery. ",
                        style: TextStyle(fontSize: size.width * 0.04),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// () async {
//             String url = "tel:0783080158";
//             if (!await launch(url)) throw 'Could not launch $url';
//           },