import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tibloo/AuthenticationModule/OTPPage.dart';
import 'package:tibloo/AuthenticationModule/RegisterPage.dart';
import 'package:tibloo/globals.dart' as global;
import 'package:http/http.dart' as http;

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ripple
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = HexColor(global.secondary_color)
    ..backgroundColor = HexColor(global.secondary_color)
    ..boxShadow = <BoxShadow>[]
    ..indicatorColor = HexColor(global.primary_color)
    ..textColor = HexColor(global.primary_color)
    ..maskColor = Colors.green.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode myFocusNode = new FocusNode();
  TextEditingController mobileController = TextEditingController();
  Future<dynamic> Authorization() async {
    var user_register_url = global.auth_api_url + "login";
    var res = await http.post(Uri.parse(user_register_url), headers: {
      "Accept": "application/json",
      "Authorization": 'Bearer ' + global.authToken,
    }, body: {
      'email': global.authEmail,
      'password': global.authPassword,
    });
    var resp = json.decode(res.body);
    global.authToken = resp['token'];
    var authStatus = res.statusCode;
    return authStatus;
  }

  Future<void> userLogin() async {
    configLoading();
    EasyLoading.show(status: 'Loading...');
    var user_register_url = global.api_base_url + "login";
    var res = await http.post(Uri.parse(user_register_url), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "contact": mobileController.text,
    });
    var resp = json.decode(res.body);
    if (resp['status'] == "0") {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
        behavior: SnackBarBehavior.floating,
        content: Text(resp['message']),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(resp);
    } else {
      EasyLoading.dismiss();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => OTPPage(mobile_no: mobileController.text)),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor(global.primary_color),
        body: Container(
          decoration: BoxDecoration(
            color: HexColor(global.primary_color),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                  ),
                ),
                child: Image.asset(
                  'assets/Tibloo.png',
                  scale: 7,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 50, left: 20),
                child: Row(
                  children: [
                    Text(
                      "Hello,Welcome To ",
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: HexColor(global.secondary_color),
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Tib",
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: HexColor(global.secondary_color),
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "loo",
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: HexColor(global.secondary_color),
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 7, left: 20),
                child: Text(
                  "Lets Get Started",
                  style: GoogleFonts.montserrat(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Image.asset(
                'assets/LoginGirl.png',
                height: 300,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  cursorColor: Colors.white,
                  maxLength: 10,
                  style: GoogleFonts.montserrat(color: Colors.white),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: "Mobile",
                    labelStyle: GoogleFonts.montserrat(color: Colors.white),
                    floatingLabelStyle:
                        GoogleFonts.montserrat(color: Colors.white),
                    prefixIcon: Icon(Icons.phone_android),
                    prefixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                          ? Colors.white
                          : Colors.white60,
                    ),
                  ),
                  controller: mobileController,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => OtpPage()));
                  setState(() {
                    if (mobileController.text.isEmpty ||
                        (mobileController.text.length != 10)) {
                      final snackBar = SnackBar(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height - 100,
                            right: 20,
                            left: 20),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                            "Please Check The Mobile Number You Have Entered"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      // print("log in api call start");
                      userLogin();
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor(global.primary_color),

                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    // color: HexColor(global.secondary_color),
                  ),
                  margin: EdgeInsets.only(left: 150, right: 150, top: 20),
                  height: 50,
                  child: Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              /*     Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New To Tibloo? ",
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: HexColor("3a7fc0")),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        "Register",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: HexColor("3a7fc0"),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/

              /*  GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor(global.primary_color),

                      border:
                          Border.all(width: 2, color: HexColor(global.primary_color)),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      // color: HexColor(global.secondary_color),
                    ),
                    margin: EdgeInsets.only(left: 40, right: 40, top: 20),
                    height: 50,
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}
