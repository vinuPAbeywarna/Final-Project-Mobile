import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vinsartisanmarket/components/p_v_slider.dart';
import 'package:vinsartisanmarket/components/tots.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';
import 'package:vinsartisanmarket/models/addcartModel.dart';
import 'package:vinsartisanmarket/models/addwishModel.dart';
import 'package:vinsartisanmarket/models/fetchCartModel.dart';
import 'package:vinsartisanmarket/models/productModel.dart';
import 'package:vinsartisanmarket/screens/home/store_tab/compt/suggestsItems.dart';
import 'package:vinsartisanmarket/screens/orders/orderdetails.dart';
import 'package:vinsartisanmarket/service/authentication/userHandeler.dart';
import 'package:vinsartisanmarket/service/http_handeler/httpClient.dart';
import 'package:vinsartisanmarket/test/testdata_handeler.dart';

class Singelitemfull extends StatefulWidget {
  const Singelitemfull({
    Key? key,
    required this.imglist,
    required this.pid,
    required this.productname,
    required this.price,
    required this.status,
    required this.description,
    required this.productmodel,
    required this.productList,
  }) : super(key: key);

  final List<Widget> imglist;
  final String pid;
  final String productname;
  final String description;
  final double price;

  final bool status;
  final Productmodel productmodel;
  final List<Productmodel> productList;

  @override
  _SingelitemfullState createState() => _SingelitemfullState();
}

class _SingelitemfullState extends State<Singelitemfull> {
  double total = 0.0;
  int itemquantity = 1;
  bool isdiscount = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // if (widget.discount > 0) {
    //   isdiscount = true;
    // } else {
    //   isdiscount = false;
    // }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () async {
                  final user = await UserHandeler.getUser();
                  final res = await httpClient.addWishList(WishListModel(
                      userid: user.id, productid: int.parse(widget.pid)));
                  if (res["data"] == "success") {
                    Customtost.commontost(
                        "Succesfully addded", Colors.greenAccent);
                  } else {
                    Customtost.commontost("Already addded", Colors.amberAccent);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    LineIcons.heart,
                    size: size.width * 0.08,
                  ),
                )),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Wrap(
          //will break to another line on overflow
          direction: Axis.horizontal, //use vertical to show  on vertical axis
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton.extended(
                    heroTag: "btn1",
                    backgroundColor: Colors.deepOrangeAccent,
                    onPressed: () async {
                      print("pressed");
                      final user = await UserHandeler.getUser();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Orderdetails(
                                    itemList: [
                                      FetchCartModel(
                                          id: 0,
                                          userid: user.id,
                                          productid: int.parse(widget.pid),
                                          qty: itemquantity,
                                          createdat: DateTime.now.toString(),
                                          updatedat: DateTime.now.toString(),
                                          product: widget.productmodel)
                                    ],
                                  )));
                    },
                    label: const Text("Buy It Now"))),
            // button third//button first

            // button second

            Container(
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton.extended(
                    heroTag: "btn2",
                    backgroundColor: Colors.indigo,
                    onPressed: () async {
                      final user = await UserHandeler.getUser();
                      if (kDebugMode) {
                        print(user.id);
                      }
                      await httpClient.addCart(CartModel(
                          userid: user.id,
                          productid: int.parse(widget.pid),
                          qty: itemquantity));
                      Customtost.cartadd();
                    },
                    label: const Text("Add to cart"))),
            // button third

            // Add more buttons here
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
                width: size.width,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  widget.productname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.06),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PVslider(list: widget.imglist),
              ),
              SizedBox(
                height: size.height * 0.01,
                width: size.width,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        "RS. " + widget.price.toStringAsFixed(0),
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.05),
                      ),
                    ),
                    Text(
                        "Category : " +
                            widget.productmodel.category.category_name,
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        )),
                  ]),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text(widget.description,
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                  ),
                  Text("Quantity  ",
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      )),
                  Container(
                    width: size.width * 0.19,
                    padding: EdgeInsets.all(size.width * 0.007),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width * 0.01),
                        color: Colors.indigoAccent),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (itemquantity > 0) {
                                setState(() {
                                  itemquantity--;
                                });
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: size.width * 0.04,
                            )),
                        Container(
                          width: size.width * 0.075,
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.007),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.007,
                              vertical: size.width * 0.005),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.007),
                              color: Colors.white),
                          child: Text(
                            itemquantity.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.04),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              if (itemquantity < 100) {
                                setState(() {
                                  itemquantity++;
                                });
                              }
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: size.width * 0.04,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: size.height * 0.01, left: size.width * 0.02),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Suggested Products ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.7),
                        fontSize: size.width * 0.05),
                  ),
                ),
              ),
              SuggestItemView(
                productlist: widget.productList,
                categoryModel: widget.productmodel.category,
              )
            ],
          ),
        ));
  }
}
