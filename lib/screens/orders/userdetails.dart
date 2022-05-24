import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vinsartisanmarket/components/internet_not_connect.dart';
import 'package:vinsartisanmarket/components/textfileds.dart';
import 'package:vinsartisanmarket/components/tots.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';
import 'package:vinsartisanmarket/models/fetchCartModel.dart';
import 'package:vinsartisanmarket/models/loggedUser.dart';
import 'package:vinsartisanmarket/models/orderModel.dart';
import 'package:vinsartisanmarket/screens/home/home_screen.dart';
import 'package:vinsartisanmarket/screens/orders/payPalscreen.dart';
import 'package:vinsartisanmarket/service/authentication/userHandeler.dart';
import 'package:vinsartisanmarket/service/http_handeler/httpClient.dart';
import 'package:vinsartisanmarket/service/network/networkhandeler.dart';
import 'package:vinsartisanmarket/service/validaters/validate_handeler.dart';

class Userdetailscreen extends StatefulWidget {
  final bool islog;
  final String text;
  final double total;
  final List<FetchCartModel> colist;

  const Userdetailscreen({
    Key? key,
    this.text = "",
    required this.colist,
    this.islog = false,
    required this.total,
  }) : super(key: key);
  @override
  _UserdetailscreenState createState() => _UserdetailscreenState();
}

class _UserdetailscreenState extends State<Userdetailscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController namecon = TextEditingController();
  TextEditingController emailcon = TextEditingController();
  TextEditingController mobilecon = TextEditingController();
  TextEditingController addresscon = TextEditingController();
  TextEditingController notecon = TextEditingController();
  TextEditingController postalcon = TextEditingController();
  TextEditingController statecon = TextEditingController();
  TextEditingController citycon = TextEditingController();

  String name = " ";
  String email = " ";
  String mobileno = " ";
  String address = " ";
  String postalcode = " ";
  String note = " ";
  String city = " ";
  String state = " ";

  var base;
  @override
  void initState() {
    super.initState();
    loaduserdata();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0XFFffffff),
        key: _scaffoldKey,
        appBar: AppBar(
            title: Center(
              child: Text(
                "Customer Details",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w700),
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            print("---------------");

            // base = Base64Decoder().convert(addressimg);
            // setState(() {
            //   isimgload = true;
            // });
            if (_formKey.currentState!.validate()) {
              bool isconnect = await NetworkHandeler.hasNetwork();
              // ignore: deprecated_member_use
              _scaffoldKey.currentState!.showSnackBar(SnackBar(
                duration: const Duration(seconds: 2),
                backgroundColor: kprimaryColor,
                content: Row(
                  children: const [
                    CircularProgressIndicator(),
                    Text("  Order Processing...")
                  ],
                ),
              ));

              if (isconnect == true) {
                final user = await UserHandeler.getUser();
                final order = OrderModel(
                    address: address,
                    full_name: name,
                    total: widget.total,
                    city: city,
                    state: state,
                    payment_type: '1',
                    postal_code: postalcode,
                    order_note: note,
                    user_id: user.id,
                    contact_no: mobileno);
                String res = await httpClient.createOrder(order);
                if (res != "null") {
                  Customtost.commontost("Order is created", Colors.green);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PayPalScreen(
                                total: widget.total,
                                orderid: res,
                              )));
                } else {
                  Customtost.commontost("Order fail", Colors.red);
                }
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NointernetScreen(
                                pushscreen: Userdetailscreen(
                              colist: widget.colist,
                              total: widget.total,
                            ))));
              }
            } else {
              print("Not Complete");
            }
          },
          label: Text(
            "Place order",
            style: TextStyle(fontSize: size.width * 0.04),
          ),
          icon: const Icon(Icons.shopping_bag_sharp),
          backgroundColor: Colors.indigo,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: Color(0XFFffffff)),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.056,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: size.height * 0.02,
                          right: size.width * 0.02,
                          left: size.width * 0.02),
                      child: Container(
                        child: Gnoiconformfiled(
                          onchange: (text) {
                            name = text;
                            print(text);
                          },
                          valid: (text) {
                            return Validater.genaralvalid(text!);
                          },
                          save: (save) {},
                          controller: namecon,
                          hintText: "Full Name",
                          label: "Full Name",
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //       bottom: size.height * 0.02,
                    //       right: size.width * 0.02,
                    //       left: size.width * 0.02),
                    //   child: Container(
                    //     // width: size.width * 0.96,
                    //     child: Gnoiconformfiled(
                    //       onchange: (text) {
                    //         email = text;
                    //       },
                    //       valid: (text) {
                    //         print(text);
                    //         return Validater.vaildemail(email);
                    //       },
                    //       save: (save) {},
                    //       controller: emailcon,
                    //       hintText: "Email",
                    //       label: "Email",
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: size.height * 0.02,
                          right: size.width * 0.02,
                          left: size.width * 0.02),
                      child: Container(
                        // width: size.width * 0.96,
                        child: Gnoiconformfiled(
                          hintText: "Contact No",
                          label: "Contact No",
                          onchange: (text) {
                            mobileno = text;
                          },
                          save: (text) {},
                          controller: mobilecon,
                          valid: (text) {
                            return Validater.genaralvalid(text!);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: size.height * 0.02,
                          right: size.width * 0.02,
                          left: size.width * 0.02),
                      child: Container(
                        // width: size.width * 0.96,
                        child: Gnoiconformfiled(
                          hintText: "Address",
                          label: "Address",
                          maxlines: 3,
                          onchange: (text) {
                            address = text;
                          },
                          save: (text) {},
                          controller: addresscon,
                          valid: (text) {
                            return Validater.genaralvalid(text!);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: size.height * 0.02,
                          right: size.width * 0.02,
                          left: size.width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Gnoiconformfiled(
                                onchange: (text) {
                                  city = text;
                                  print(text);
                                },
                                valid: (text) {
                                  return Validater.genaralvalid(text!);
                                },
                                save: (save) {},
                                controller: citycon,
                                hintText: "City",
                                label: "City",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Gnoiconformfiled(
                                onchange: (text) {
                                  state = text;
                                },
                                valid: (text) {
                                  print(text);
                                  return Validater.genaralvalid(text!);
                                },
                                save: (save) {},
                                controller: statecon,
                                hintText: "State",
                                label: "State",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: size.height * 0.02,
                          right: size.width * 0.02,
                          left: size.width * 0.02),
                      child: Container(
                        // width: size.width * 0.96,
                        child: Gnoiconformfiled(
                          hintText: "Postal Code",
                          label: "Postal Code",
                          maxlines: 1,
                          onchange: (text) {
                            postalcode = text;
                          },
                          save: (text) {},
                          controller: postalcon,
                          valid: (text) {
                            return Validater.genaralvalid(text!);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: size.height * 0.02,
                          right: size.width * 0.02,
                          left: size.width * 0.02),
                      child: Container(
                        // width: size.width * 0.96,
                        child: Gnoiconformfiled(
                          hintText: "Note",
                          label: "Order note(Optional)",
                          maxlines: 2,
                          onchange: (text) {
                            note = text;
                          },
                          save: (text) {},
                          controller: notecon,
                          valid: (text) {
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                // bottom: size.height * 0.02,
                                right: size.width * 0.02,
                                left: size.width * 0.02),
                            child: Text("Payment Methods",
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.00),
                            child: Row(children: [
                              Radio(
                                value: 1,
                                groupValue: 1,
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                              Image.asset(
                                "assets/icons/paypal.png",
                                width: size.width * 0.2,
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoggedUserModel user;
    user = LoggedUserModel.fromMap(jsonDecode(prefs.getString('user') ?? '{}'));
    namecon.text = user.name;
    emailcon.text = user.email;
    addresscon.text = user.address;
    mobilecon.text = user.contctno;
    name = user.name;
    email = user.email;
    address = user.address;
    mobileno = user.contctno;

    setState(() {});
  }
}
