import 'dart:convert';

import 'package:flutter/material.dart';
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
        // backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            color: HexColor(global.primary_color),
            image: DecorationImage(
                image: AssetImage("assets/waves_blue.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  /*  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Image.asset(
                            'assets/logo.jpeg',
                            height: 60,
                          ),
                        ),
                      ],
                    ),*/
                  Container(
                    padding: EdgeInsets.only(top: 50, left: 20),
                    child: Row(
                      children: [
                        Text(
                          "Hello,Welcome To ",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "TIB",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Loo",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Colors.white,
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
                          color: HexColor(global.secondary_color),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Image.asset(
                    'assets/laptopback.png',
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
                              : Colors.white,
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
                                bottom:
                                    MediaQuery.of(context).size.height - 100,
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
                ],
              ),
              Container(
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
              ),

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
