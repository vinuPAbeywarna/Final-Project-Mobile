import 'package:flutter/material.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';

import 'package:vinsartisanmarket/components/already_have_an_account_acheck.dart';
import 'package:vinsartisanmarket/components/buttons.dart';
import 'package:vinsartisanmarket/components/internet_not_connect.dart';
import 'package:vinsartisanmarket/components/textfileds.dart';
import 'package:vinsartisanmarket/components/tots.dart';
import 'package:vinsartisanmarket/screens/auth/signin.dart';

import 'package:vinsartisanmarket/service/network/networkhandeler.dart';
import 'package:vinsartisanmarket/service/validaters/validate_handeler.dart';

import 'background.dart';

class EditUserdetails extends StatefulWidget {
  final String uname;
  final String uemail;
  final String umobile;
  const EditUserdetails(
      {Key? key,
      required this.uname,
      required this.uemail,
      required this.umobile})
      : super(key: key);

  @override
  _EditUserdetailsState createState() => _EditUserdetailsState();
}

class _EditUserdetailsState extends State<EditUserdetails> {
  bool status = false;
  String name = "";
  String mobileno = "";
  String email = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController scondnamecontroller = TextEditingController();
  TextEditingController mobilenicontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
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
                      "Edit User Details",
                      style: TextStyle(
                          fontSize: size.width * 0.068,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
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
                                      new Text("Updating ...")
                                    ],
                                  ),
                                ));
                                print("valid");
                              } else {
                                print("not complete");
                              }
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NointernetScreen(
                                              pushscreen: EditUserdetails(
                                            uemail: widget.uemail,
                                            umobile: widget.umobile,
                                            uname: widget.uname,
                                          ))));
                            }
                          },
                          color: kprimaryColor,
                          text: "Update",
                        ),
                      ),
                    ),
                    //OrDivider(),

                    SizedBox(
                      height: size.height * 0.08,
                    ),
                  ]),
            ))),
      ),
    );
  }

  loaddata() {
    namecontroller.text = widget.uname;
    mobilenicontroller.text = widget.umobile;
    emailcontroller.text = widget.uemail;
    setState(() {});
  }
}
