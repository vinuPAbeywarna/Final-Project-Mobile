import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinsartisanmarket/components/buttons.dart';
import 'package:vinsartisanmarket/components/errorpage.dart';
import 'package:vinsartisanmarket/components/internet_not_connect.dart';
import 'package:vinsartisanmarket/components/popup_dilog.dart';
import 'package:vinsartisanmarket/components/tots.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';
import 'package:vinsartisanmarket/models/loggedUser.dart';
import 'package:vinsartisanmarket/screens/auth/edituserdetail.dart';
import 'package:vinsartisanmarket/screens/auth/signin.dart';
import 'package:vinsartisanmarket/screens/home/home_screen.dart';
import 'package:vinsartisanmarket/screens/info/info.dart';
import 'package:vinsartisanmarket/service/network/networkhandeler.dart';
import 'package:vinsartisanmarket/test/testdata_handeler.dart';
import 'package:vinsartisanmarket/test/testmodel.dart';

import 'orderhistorylist.dart';

class Userdetails extends StatefulWidget {
  const Userdetails({Key? key}) : super(key: key);

  @override
  _UserdetailsState createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  late Future<TestModel> futureData;

  final bool stat = true;
  String name = '';
  String email = " ";
  String role = '';
  String address = " ";
  String nic = '';
  String mobileno = '';
  String birthday = '';

  loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoggedUserModel user;
    user = LoggedUserModel.fromMap(jsonDecode(prefs.getString('user') ?? '{}'));
    name = user.name;
    email = user.email;
    role = user.role;
    address = user.address;
    birthday = user.birthday;
    nic = user.nic;
    mobileno = user.contctno;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loaduserdata();
    futureData = TestDataHandeler.fetchTestModelsingel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            TestModel data = snapshot.data as TestModel;

            return Container(
                child: Scaffold(
                    backgroundColor: Colors.indigo.withOpacity(0.1),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                    floatingActionButton: Wrap(
                      //will break to another line on overflow
                      direction: Axis
                          .horizontal, //use vertical to show  on vertical axis
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(5),
                            child: FloatingActionButton.extended(
                                icon: Icon(Icons.history),
                                heroTag: "btn1",
                                backgroundColor: kprimaryColor,
                                onPressed: () async {
                                  bool isconnect =
                                      await NetworkHandeler.hasNetwork();
                                  print(isconnect);
                                  if (isconnect == true) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                // ignore: prefer_const_constructors
                                                Orderhistoryscreen(
                                                  uid: "ff",
                                                )));
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NointernetScreen(
                                                    pushscreen:
                                                        HomeScreen(index: 0))));
                                  }
                                },
                                label: const Text("Order history"))),
                        // button third//button first

                        // button second

                        Container(
                            margin: const EdgeInsets.all(5),
                            child: FloatingActionButton.extended(
                                icon: const Icon(Icons.edit),
                                heroTag: "btn2",
                                backgroundColor: Colors.green,
                                onPressed: () async {
                                  bool isconnect =
                                      await NetworkHandeler.hasNetwork();

                                  if (isconnect == true) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditUserdetails(
                                                    uname: name,
                                                    uemail: email,
                                                    umobile: mobileno)));
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NointernetScreen(
                                                    pushscreen:
                                                        Userdetails())));
                                  }
                                },
                                label: const Text("Edit Profile"))),
                        // button third

                        // Add more buttons here
                      ],
                    ),
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      backgroundColor: Colors.indigo.withOpacity(0.1),
                      title: Center(
                        child: Text(
                          "User Account",
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: size.width * 0.02,
                              top: size.height * 0.004),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 0.5))),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: size.width * 0.08,
                                  ),
                                  color: Colors.indigoAccent.shade700,
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Infoscreen()));
                                  })),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: size.width * 0.02,
                              top: size.height * 0.004),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 0.5))),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.logout,
                                    size: size.width * 0.08,
                                  ),
                                  color: Colors.indigo.shade700,
                                  onPressed: () async {
                                    PopupDialog.showPopuplogout(
                                        context,
                                        "Signout",
                                        "Do you want to signout ? ", () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.clear();
                                      Get.offAll(() => const Signin());
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const Signin()));
                                    });
                                  })),
                        )
                      ],
                    ),
                    body: Container(
                        child: ListView(
                      children: [
                        SizedBox(
                          height: size.height * 0.07,
                        ),
                        Container(
                            width: size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    child: Image.asset('assets/icons/man.png'),
                                    radius: size.width * 0.28,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                                Container(
                                  width: size.width * 0.92,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 0.08))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.018,
                                            left: size.width * 0.035),
                                        child: Text.rich(
                                          TextSpan(
                                            text: 'Name : ',
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
                                                fontWeight: FontWeight
                                                    .w800), // default text style
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: name,
                                                style: TextStyle(
                                                    fontSize: size.width * 0.05,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.018,
                                            left: size.width * 0.035),
                                        child: Text.rich(
                                          TextSpan(
                                            text: 'Email : ',
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
                                                fontWeight: FontWeight
                                                    .w800), // default text style
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: email,
                                                style: TextStyle(
                                                    fontSize: size.width * 0.05,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.018,
                                            left: size.width * 0.035),
                                        child: Text.rich(
                                          TextSpan(
                                            text: 'Mobile No : ',
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
                                                fontWeight: FontWeight
                                                    .w800), // default text style
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: mobileno,
                                                style: TextStyle(
                                                    fontSize: size.width * 0.05,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.018,
                                            left: size.width * 0.035),
                                        child: Text.rich(
                                          TextSpan(
                                            text: 'NIC No : ',
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
                                                fontWeight: FontWeight
                                                    .w800), // default text style
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: nic,
                                                style: TextStyle(
                                                    fontSize: size.width * 0.05,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.018,
                                            left: size.width * 0.035),
                                        child: Text.rich(
                                          TextSpan(
                                            text: 'Birthday : ',
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
                                                fontWeight: FontWeight
                                                    .w800), // default text style
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: birthday,
                                                style: TextStyle(
                                                    fontSize: size.width * 0.05,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.018,
                                            left: size.width * 0.035),
                                        child: Text.rich(
                                          TextSpan(
                                            text: 'Address : ',
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
                                                fontWeight: FontWeight
                                                    .w800), // default text style
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: address,
                                                style: TextStyle(
                                                    fontSize: size.width * 0.05,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.018,
                                            left: size.width * 0.035),
                                        child: Text.rich(
                                          TextSpan(
                                            text: 'Role : ',
                                            style: TextStyle(
                                                fontSize: size.width * 0.05,
                                                fontWeight: FontWeight
                                                    .w800), // default text style
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "I'm a Buyer",
                                                style: TextStyle(
                                                    fontSize: size.width * 0.05,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                              ],
                            ))
                      ],
                    )))); //catdatanotfound

          } else if (snapshot.hasError) {
            return Errorpage(size: size.width * 0.7);
          }
          // By default show a loading spinner.
          return Center(
              child: Lottie.asset("assets/animation/loadingindicator.json",
                  width: size.width * 0.28));
        },
      ),
    );
  }

  loaddata(String uid) async {
    futureData = TestDataHandeler.fetchTestModelsingel();
  }
}
