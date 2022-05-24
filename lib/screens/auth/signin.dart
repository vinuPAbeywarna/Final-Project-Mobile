import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:vinsartisanmarket/components/primaryLoadingIndicator.dart';
import 'package:vinsartisanmarket/components/snackBar.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';

import 'package:vinsartisanmarket/components/already_have_an_account_acheck.dart';
import 'package:vinsartisanmarket/components/buttons.dart';

import 'package:vinsartisanmarket/components/forgot_password.dart';
import 'package:vinsartisanmarket/components/internet_not_connect.dart';
import 'package:vinsartisanmarket/components/or_divider.dart';
import 'package:vinsartisanmarket/components/textfileds.dart';
import 'package:vinsartisanmarket/components/tots.dart';
import 'package:vinsartisanmarket/screens/home/home_screen.dart';
import 'package:vinsartisanmarket/screens/layout.dart';
import 'package:vinsartisanmarket/service/network/networkhandeler.dart';
import 'package:vinsartisanmarket/service/validaters/validate_handeler.dart';

import 'package:get/get.dart';
import 'package:vinsartisanmarket/Models/AuthUser.dart';
import 'package:vinsartisanmarket/service/http_handeler/httpClient.dart';

import 'background.dart';
import 'signup.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool status = false;
  String email = "";
  String password = "";
  RxBool loading = false.obs;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernamecontroller = TextEditingController();
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
                    Text(
                      "Welcome to  VinS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: size.width * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade500),
                    ),
                    SizedBox(
                      height: size.height * 0.12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.02),
                      child: Container(
                        width: size.width * 0.8,
                        child: Gtextformfiled(
                          keybordtype: TextInputType.text,
                          hintText: "Email",
                          label: "Email",
                          onchange: (text) {
                            email = text;
                          },
                          save: (text) {
                            email = text!;
                          },
                          controller: usernamecontroller,
                          icon: Icons.email_outlined,
                          valid: (text) {
                            return Validater.vaildemail(email);
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
                                print(text);
                                password = text;
                              },
                              save: (text) {
                                password = text!;
                              },
                              icon: Icons.lock,
                            ))),
                    status
                        ? Padding(
                            padding: EdgeInsets.only(
                              bottom: size.height * 0.05,
                            ),
                            child: Wrap(
                              children: [
                                Text(
                                  "Invalid mobile number or password ",
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
                      child: Obx(() => loading.value
                          ? primaryLoadingIndicator()
                          : Container(
                              width: size.width * 0.65,
                              child: Iconbutton(
                                bicon: Icon(Icons.login),
                                onpress: () async {
                                  bool isconnect =
                                      await NetworkHandeler.hasNetwork();

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
                                            new Text("Authenticating ...")
                                          ],
                                        ),
                                      ));
                                      signInuser();
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) {
                                      //       return const HomeScreen();
                                      //     },
                                      //   ),
                                      // );

                                      print("valid");
                                    } else {
                                      print("not complete");
                                    }
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NointernetScreen(
                                                    pushscreen: Signup())));
                                  }
                                },
                                color: kprimaryColor,
                                text: "Sign In",
                              ),
                            )),
                    ),
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Signup();
                            },
                          ),
                        );
                      },
                    ),
                    OrDivider(),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return Forgetpasswordscreen();
                          //     },
                          //   ),
                          // );
                        },
                        child: Text(
                          "Forgot password ?",
                          style: TextStyle(
                              //fontSize: size.width * 0.025,
                              fontWeight: FontWeight.bold,
                              color: status
                                  ? kprimaryColor
                                  : Colors.black.withOpacity(0.7)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                  ]),
            ))),
      ),
    );
  }

  void signInuser() async {
    loading.value = true;
    Map res = await httpClient.signIn({'email': email, 'password': password});

    if (kDebugMode) {
      print(res);
    }

    if (res['code'] == 200) {
      httpClient.setToken(res['data']['token']);
      authUser.saveUser(res['data']['user']);
      Get.offAll(() => const HomeScreen());
    } else {
      showSnackBar('Oops!', 'Email/Password is incorrect. Please try again.');
      status = true;
      setState(() {});
      loading.value = false;
    }
    setState(() {});
    loading.value = false;
  }
}
