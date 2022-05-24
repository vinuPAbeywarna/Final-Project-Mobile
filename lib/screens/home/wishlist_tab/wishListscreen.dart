import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:vinsartisanmarket/components/tots.dart';
import 'package:vinsartisanmarket/constansts/initdata.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';

import 'package:vinsartisanmarket/models/addwishModel.dart';
import 'package:vinsartisanmarket/models/fetchWishModel.dart';
import 'package:vinsartisanmarket/screens/home/cart_tab/compt/emtycart.dart';
import 'package:vinsartisanmarket/screens/home/wishlist_tab/compt/emtyWishList.dart';
import 'package:vinsartisanmarket/screens/orders/orderdetails.dart';
import 'package:vinsartisanmarket/service/http_handeler/httpClient.dart';
import 'package:vinsartisanmarket/test/testdata_handeler.dart';

import 'package:line_icons/line_icons.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late Future<List<FetchWishListModel>> futureData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double total = 9500;
  int cartitemcount = 1;
  @override
  void initState() {
    super.initState();
    futureData = httpClient.getWishList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<FetchWishListModel> data =
              snapshot.data as List<FetchWishListModel>;

          if (data.isNotEmpty) {
            print(data);
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kprimaryColor,
                title: Center(
                    child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(LineIcons.heart),
                    const Text("WishList")
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
                                return Card(
                                  color: Colors.white,
                                  child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
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
                                              child: CircularProgressIndicator(
                                                  color: Colors.indigoAccent,
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
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
                                        Text(
                                            "RS. " +
                                                data[indext]
                                                    .product
                                                    .price
                                                    .toStringAsFixed(0),
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.7))),
                                      ]),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              httpClient.removeWishListItem(
                                                  data[indext].id);
                                              Customtost.cartitemremove();
                                              reloaddata();
                                            },
                                            icon:
                                                Icon(LineIcons.minusSquareAlt),
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            iconSize: size.width * 0.06,
                                          )
                                        ],
                                      )),
                                );
                              })),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const EmptyWishList();
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
      futureData = futureData = httpClient.getWishList();
    });
  }
}
