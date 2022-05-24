import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:vinsartisanmarket/components/tots.dart';
import 'package:vinsartisanmarket/constansts/initdata.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';
import 'package:vinsartisanmarket/models/fetchCartModel.dart';
import 'package:vinsartisanmarket/screens/home/cart_tab/compt/emtycart.dart';
import 'package:vinsartisanmarket/screens/orders/orderdetails.dart';
import 'package:vinsartisanmarket/service/authentication/userHandeler.dart';
import 'package:vinsartisanmarket/service/http_handeler/httpClient.dart';
import 'package:vinsartisanmarket/test/testdata_handeler.dart';

import 'package:line_icons/line_icons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<FetchCartModel>> futureData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double total = 9500;
  int cartitemcount = 1;
  @override
  void initState() {
    super.initState();
    futureData = httpClient.getCart();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<FetchCartModel> data = snapshot.data as List<FetchCartModel>;

          if (data.isNotEmpty) {
            print(data);
            return Scaffold(
              key: _scaffoldKey,
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  // ScaffoldMessenger.of(context).showSnackBar;

                  // ignore: deprecated_member_use
                  _scaffoldKey.currentState!.showSnackBar(SnackBar(
                    duration: Duration(seconds: 1),
                    backgroundColor: kprimaryColor,
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        Text("  Checking...")
                      ],
                    ),
                  ));

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Orderdetails(
                                itemList: data,
                              )));
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Check out all"),
                backgroundColor: Colors.indigoAccent,
              ),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kprimaryColor,
                title: Center(
                    child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(LineIcons.shoppingCart),
                    const Text("Cart")
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
              ),
              body: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, indext) {
                                int itemquantity = data[indext].qty;
                                return GestureDetector(
                                  onTap: () async {
                                    final user = await UserHandeler.getUser();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Orderdetails(
                                                  itemList: [data[indext]],
                                                )));
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                        leading: Container(
                                            child: Container(
                                          child: CachedNetworkImage(
                                            width: size.width * 0.175,
                                            imageUrl: imgebaseUrl +
                                                data[indext].product.image,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Container(
                                              //  height: size.height * 0.01,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color:
                                                            Colors.indigoAccent,
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                          // child: Image.network(
                                          //   fiximagelink + data[indext].imgname,
                                          //   width: size.width * 0.175,
                                          // ),
                                        )),
                                        title: Text(
                                          data[indext].product.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.037),
                                        ),
                                        subtitle: Row(children: [
                                          Expanded(
                                            child: Text(
                                                "RS. " +
                                                    data[indext]
                                                        .product
                                                        .price
                                                        .toStringAsFixed(0),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.7))),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.02,
                                              ),
                                              Text("Quantity  ",
                                                  style: TextStyle(
                                                    // fontSize: size.width * 0.04,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  )),
                                              Container(
                                                width: size.width * 0.17,
                                                padding: EdgeInsets.all(
                                                    size.width * 0.007),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            size.width * 0.01),
                                                    color:
                                                        Colors.indigo.shade400),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          if (itemquantity >
                                                              0) {
                                                            setState(() {
                                                              itemquantity--;
                                                            });
                                                          }
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          size:
                                                              size.width * 0.03,
                                                        )),
                                                    Container(
                                                      width: size.width * 0.075,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  size.width *
                                                                      0.007),
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                              horizontal:
                                                                  size.width *
                                                                      0.007,
                                                              vertical:
                                                                  size.width *
                                                                      0.005),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(size
                                                                          .width *
                                                                      0.007),
                                                          color: Colors.white),
                                                      child: Text(
                                                        itemquantity.toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                size.width *
                                                                    0.03),
                                                      ),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          if (itemquantity <
                                                              1000) {
                                                            setState(() {
                                                              itemquantity++;
                                                            });
                                                          }
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                          size:
                                                              size.width * 0.03,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                httpClient.removeCartItem(
                                                    data[indext].id);
                                                Customtost.cartitemremove();
                                                reloaddata();
                                              },
                                              icon: Icon(LineIcons.minusCircle),
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              iconSize: size.width * 0.06,
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              })),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Emptycart();
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default show a loading spinner.
        return Center(
            child: Lottie.asset("assets/animation/loadingindicator.json",
                width: size.height * 0.3));
      },
    );
  }

  reloaddata() {
    setState(() {
      futureData = futureData = httpClient.getCart();
    });
  }
}
