import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:vinsartisanmarket/components/snackBar.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';

import 'package:vinsartisanmarket/components/already_have_an_account_acheck.dart';
import 'package:vinsartisanmarket/components/buttons.dart';
import 'package:vinsartisanmarket/components/internet_not_connect.dart';
import 'package:vinsartisanmarket/components/textfileds.dart';
import 'package:vinsartisanmarket/components/tots.dart';
import 'package:vinsartisanmarket/models/authUser.dart';
import 'package:vinsartisanmarket/models/regiUser.dart';
import 'package:vinsartisanmarket/screens/auth/signin.dart';
import 'package:vinsartisanmarket/screens/home/home_screen.dart';
import 'package:vinsartisanmarket/service/http_handeler/httpClient.dart';

import 'package:vinsartisanmarket/service/network/networkhandeler.dart';
import 'package:vinsartisanmarket/service/validaters/validate_handeler.dart';

import 'background.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool status = false;
  String name = "";
  String address = "";
  String mobileno = "";
  String email = "";
  String password = "";
  String city = "";
  String nic = "";
  String bday = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController mobilenicontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController niccontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController birthdaycontroller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Background(
                child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      child: Text(
                        "Register with VinS",
                        style: TextStyle(
                            fontSize: size.width * 0.068,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.047,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.02),
                      child: Container(
                        width: size.width * 0.8,
                        child: Gtextformfiled(
                          hintText: "Name",
                          label: "Name",
                          onchange: (text) {
                            name = text;
                          },
                          save: (text) {
                            name = text!;
                          },
                          controller: namecontroller,
                          icon: Icons.person,
                          valid: (text) {
                            return Validater.genaralvalid(text!);
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.02),
                      child: Container(
                        width: size.width * 0.8,
                        child: Gtextformfiled(
                          hintText: "Email ",
                          label: "Email ",
                          onchange: (text) {
                            email = text;
                          },
                          save: (text) {
                            email = text!;
                          },
                          controller: emailcontroller,
                          icon: Icons.mail,
                          valid: (text) {
                            return Validater.vaildemail(email);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.02),
                      child: Container(
                        width: size.width * 0.8,
                        child: Gtextformfiled(
                          keybordtype: TextInputType.phone,
                          hintText: "Mobile No",
                          label: "Mobile No",
                          onchange: (text) {
                            mobileno = text;
                          },
                          save: (text) {
                            mobileno = text!;
                          },
                          controller: mobilenicontroller,
                          icon: Icons.phone_android,
                          valid: (text) {
                            return Validater.genaralvalid(text!);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.02),
                      child: Container(
                        width: size.width * 0.8,
                        child: Gtextformfiled(
                          keybordtype: TextInputType.text,
                          hintText: "NIC No",
                          label: "NIC No",
                          onchange: (text) {
                            nic = text;
                          },
                          save: (text) {
                            nic = text!;
                          },
                          controller: niccontroller,
                          icon: Icons.sim_card,
                          valid: (text) {
                            return Validater.genaralvalid(text!);
                          },
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.01),
                        child: Container(
                            width: size.width * 0.8,
                            child: Gpasswordformfiled(
                              onchange: (text) {
                                password = text;
                              },
                              save: (text) {
                                password = text!;
                              },
                              icon: Icons.lock,
                            ))),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.02),
                      child: Container(
                        width: size.width * 0.8,
                        child: Gtextformfiled(
                          keybordtype: TextInputType.number,
                          hintText: "Birthday",
                          label: "Birthday",
                          onchange: (text) {
                            bday = text;
                          },
                          save: (text) {
                            bday = text!;
                          },
                          controller: birthdaycontroller,
                          icon: Icons.date_range_outlined,
                          valid: (text) {
                            return Validater.genaralvalid(text!);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.02),
                      child: Container(
                        width: size.width * 0.8,
                        child: Gtextformfiled(
                          keybordtype: TextInputType.text,
                          hintText: "Address",
                          label: "Address",
                          maxlines: 2,
                          onchange: (text) {
                            address = text;
                          },
                          save: (text) {
                            address = text!;
                          },
                          controller: addresscontroller,
                          icon: Icons.location_on,
                          valid: (text) {
                            return Validater.genaralvalid(text!);
                          },
                        ),
                      ),
                    ),

                    status
                        ? Padding(
                            padding: EdgeInsets.only(
                              bottom: size.height * 0.05,
                            ),
                            child: Wrap(
                              children: [
                                Text(
                                  "Account already exist ",
                                  style: TextStyle(
                                      fontSize: size.width * 0.03,
                                      color: Colors.redAccent),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: size.height * 0,
                          ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: size.height * 0.02, left: size.width * 0.079),
                      child: Container(
                        width: size.width * 0.65,
                        child: Iconbutton(
                          bicon: Icon(Icons.app_registration),
                          onpress: () async {
                            bool isconnect = await NetworkHandeler.hasNetwork();

                            if (isconnect == true) {
                              if (_formKey.currentState!.validate()) {
                                _scaffoldKey.currentState!
                                    // ignore: deprecated_member_use
                                    .showSnackBar(new SnackBar(
                                  duration: new Duration(seconds: 3),
                                  backgroundColor: kprimaryColor,
                                  content: new Row(
                                    children: <Widget>[
                                      new CircularProgressIndicator(),
                                      new Text("Registering ...")
                                    ],
                                  ),
                                ));
                                signUpuser();
                                print("valid");
                              } else {
                                print("not complete");
                              }
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NointernetScreen(
                                              pushscreen: Signup())));
                            }
                          },
                          color: kprimaryColor,
                          text: "Sign Up",
                        ),
                      ),
                    ),
                    //OrDivider(),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Signin();
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                  ]),
            ))),
      ),
    );
  }

  RxBool loading = false.obs;

  void signUpuser() async {
    loading.value = true;
    RegiUserModel userModel = RegiUserModel(
        name: namecontroller.text,
        email: emailcontroller.text,
        password: password,
        conpassword: password,
        role: 'buyer',
        birthday: bday,
        city: ' ',
        address: address,
        contctno: mobileno,
        nic: nic);
    if (kDebugMode) {
      print(userModel.toMap());
    }
    Map res = await httpClient.signUp(userModel);

    if (kDebugMode) {
      print(res);
    }
    if (res['code'] == 200) {
      Customtost.commontost("Registered successful", Colors.green);

      if (kDebugMode) {
        print("sucessfull");
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const Signin();
          },
        ),
      );

      // Map reslog = await httpClient
      //     .signIn({'email': emailcontroller.text, 'password': password});
      // if (reslog['code'] == 200) {
      //   httpClient.setToken(res['data']['token']);
      //   authUser.saveUser(res['data']['user']);
      //   Get.offAll(() => const HomeScreen());
      // }
    } else {
      showSnackBar('Oops!', 'Account already exist. Please try again.');
      status = true;
      setState(() {});
      loading.value = false;
    }

    loading.value = false;
    setState(() {});
  }
}
