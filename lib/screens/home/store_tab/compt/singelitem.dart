import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:vinsartisanmarket/components/buttons.dart';
import 'package:vinsartisanmarket/components/internet_not_connect.dart';
import 'package:vinsartisanmarket/components/tots.dart';
import 'package:vinsartisanmarket/models/addcartModel.dart';
import 'package:vinsartisanmarket/screens/home/home_screen.dart';
import 'package:vinsartisanmarket/service/authentication/userHandeler.dart';
import 'package:vinsartisanmarket/service/http_handeler/httpClient.dart';
import 'package:vinsartisanmarket/service/network/networkhandeler.dart';

class SingleItem extends StatefulWidget {
  final String pid;
  final String titel;
  final double price;
  final double preprice;
  final double discount;
  final String imgname;
  final bool status;

  const SingleItem({
    Key? key,
    required this.titel,
    required this.price,
    required this.discount,
    required this.imgname,
    required this.pid,
    required this.preprice,
    required this.status,
  }) : super(key: key);

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late bool isdiscount;

  @override
  Widget build(BuildContext context) {
    if (widget.discount > 0) {
      isdiscount = true;
    } else {
      isdiscount = false;
    }
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.3,
      // height: size.height * 0.2,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Padding(
                  padding: EdgeInsets.all(size.height * 0.001),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 0)),
                    child: CachedNetworkImage(
                      imageUrl: widget.imgname,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                        //  height: size.height * 0.01,
                        child: Center(
                          child: CircularProgressIndicator(
                              color: Colors.blueGrey,
                              value: downloadProgress.progress),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )), // Image.network(fiximagelink + widget.imgname)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.002),
            child: Text(
              widget.titel,
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "RS. " + widget.price.toStringAsFixed(0),
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: size.width * 0.01,
            ),
            isdiscount
                ? Text("RS. " + widget.preprice.toStringAsFixed(0),
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough))
                : SizedBox(
                    width: size.width * 0.0,
                  ),
          ]),
          //Customtost.commontost("THis item out of stock", Colors.amber);
          widget.status
              ? Iconbutton(
                  bicon: Icon(Icons.shopping_cart),
                  onpress: () async {
                    bool isconnect = await NetworkHandeler.hasNetwork();

                    if (isconnect == true) {
                      final user = await UserHandeler.getUser();
                      if (kDebugMode) {
                        print(user.id);
                      }
                      await httpClient.addCart(CartModel(
                          userid: user.id,
                          productid: int.parse(widget.pid),
                          qty: 1));
                      Customtost.cartadd();
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NointernetScreen(
                                  pushscreen: HomeScreen())));
                    }
                  },
                  fontsize: size.width * 0.03,
                  text: "Add ",
                  pbottom: 0,
                  ptop: 0,
                  pleft: size.width * 0.058,
                  pright: size.width * 0.058,
                )
              : Genaralbutton(
                  // bicon: Icon(Icons.shopping_cart_outlined),
                  onpress: () {
                    Customtost.commontost(
                        "This item out of stock", Colors.amber);
                  },
                  fontsize: size.width * 0.028,
                  text: "Out of stock ",
                  pbottom: 0,
                  ptop: 0,
                  pleft: size.width * 0.058,
                  pright: size.width * 0.058,
                  color: Colors.redAccent,
                )
        ],
      ),
    );
  }
}
