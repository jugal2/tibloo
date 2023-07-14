import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tibloo/AuthenticationModule/LoginPage.dart';
import 'package:tibloo/AuthenticationModule/OTPPage.dart';
import 'package:tibloo/globals.dart' as global;
import 'package:http/http.dart' as http;

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ripple
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = HexColor(global.primary_color)
    ..backgroundColor = HexColor(global.primary_color)
    ..boxShadow = <BoxShadow>[]
    ..indicatorColor = HexColor(global.secondary_color)
    ..textColor = HexColor(global.secondary_color)
    ..maskColor = Colors.green.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FocusNode myFocusNode = new FocusNode();
  TextEditingController mobileController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool validateName(String value) {
    Pattern pattern = r'^[a-zA-Z ]+$';
    RegExp regex = new RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }

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

  Future<void> userRegister() async {
    configLoading();
    EasyLoading.show(status: 'Loading...');
    final auths = await Authorization();
    var user_register_url = global.api_base_url + "register";
    var res = await http.post(Uri.parse(user_register_url), headers: {
      "Accept": "application/json",
      "Authorization": 'Bearer ' + global.authToken,
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "email": emailController.text,
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
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/wavesreg.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Positioned.fill(
              top: 60,
              child: Image.asset(
                'assets/blobreg.png',
                alignment: Alignment.topRight,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 50, left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Hello,Welcome To ",
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: HexColor(global.primary_color),
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "TIB",
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: HexColor(global.primary_color),
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Loo",
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: HexColor(global.primary_color),
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
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextField(
                        style: GoogleFonts.montserrat(
                            color: HexColor(global.primary_color)),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor(global.primary_color)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor(global.primary_color)),
                          ),
                          labelText: "First Name",
                          labelStyle: GoogleFonts.montserrat(
                              color: HexColor(global.primary_color)),
                          floatingLabelStyle: GoogleFonts.montserrat(
                              color: HexColor(global.primary_color)),
                          prefixIcon: Icon(Icons.person_2_outlined),
                          prefixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? HexColor(global.primary_color)
                                : HexColor(global.primary_color),
                          ),
                        ),
                        controller: firstNameController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextField(
                        style: GoogleFonts.montserrat(
                            color: HexColor(global.primary_color)),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor(global.primary_color)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor(global.primary_color)),
                          ),
                          labelText: "Last Name",
                          labelStyle: GoogleFonts.montserrat(
                              color: HexColor(global.primary_color)),
                          floatingLabelStyle: GoogleFonts.montserrat(
                              color: HexColor(global.primary_color)),
                          prefixIcon: Icon(Icons.person_2_outlined),
                          prefixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? HexColor(global.primary_color)
                                : HexColor(global.primary_color),
                          ),
                        ),
                        controller: lastNameController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextField(
                        style: GoogleFonts.montserrat(
                            color: HexColor(global.primary_color)),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor(global.primary_color)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor(global.primary_color)),
                          ),
                          labelText: "Mobile",
                          labelStyle: GoogleFonts.montserrat(
                              color: HexColor(global.primary_color)),
                          floatingLabelStyle: GoogleFonts.montserrat(
                              color: HexColor(global.primary_color)),
                          prefixIcon: Icon(Icons.phone_android),
                          prefixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? HexColor(global.primary_color)
                                : HexColor(global.primary_color),
                          ),
                        ),
                        controller: mobileController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextField(
                        style: GoogleFonts.montserrat(
                            color: HexColor(global.primary_color)),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor(global.primary_color)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor(global.primary_color)),
                          ),
                          labelText: "Email",
                          labelStyle: GoogleFonts.montserrat(
                              color: HexColor(global.primary_color)),
                          floatingLabelStyle: GoogleFonts.montserrat(
                              color: HexColor(global.primary_color)),
                          prefixIcon: Icon(Icons.email_outlined),
                          prefixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? HexColor(global.primary_color)
                                : HexColor(global.primary_color),
                          ),
                        ),
                        controller: emailController,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (firstNameController.text.isEmpty ||
                            validateName(firstNameController.text) == false) {
                          final snackBar = SnackBar(
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height - 100,
                                right: 20,
                                left: 20),
                            behavior: SnackBarBehavior.floating,
                            content:
                                Text("Please Check The First Name You Entered"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (lastNameController.text.isEmpty ||
                            validateName(lastNameController.text) == false) {
                          final snackBar = SnackBar(
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height - 100,
                                right: 20,
                                left: 20),
                            behavior: SnackBarBehavior.floating,
                            content:
                                Text("Please Check The Last Name You Entered"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (mobileController.text.isEmpty ||
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
                        } else if (emailController.text.isEmpty ||
                            validateEmail(emailController.text) == false) {
                          final snackBar = SnackBar(
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height - 100,
                                right: 20,
                                left: 20),
                            behavior: SnackBarBehavior.floating,
                            content:
                                Text("Please Check The Email You Have Entered"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          userRegister();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,

                          border: Border.all(
                              width: 1, color: HexColor(global.primary_color)),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          // color: HexColor(global.secondary_color),
                        ),
                        margin: EdgeInsets.only(left: 150, right: 150, top: 20),
                        height: 50,
                        child: Center(
                          child: Text(
                            "Register",
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                color: HexColor(global.primary_color),
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
                        "Joined us before? ",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
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
                        MaterialPageRoute(builder: (context) => RegisterPage()));
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
          ],
        ),
      ),
    );
  }
}
