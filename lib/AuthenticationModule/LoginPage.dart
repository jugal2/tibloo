import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tibloo/AuthenticationModule/OTPPage.dart';
import 'package:tibloo/AuthenticationModule/RegisterPage.dart';
import 'package:tibloo/globals.dart' as global;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
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
                  padding: EdgeInsets.only(top: 30, left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Hello,Welcome To ",
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "TIB",
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: HexColor(global.secondary_color),
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
                  padding: EdgeInsets.only(top: 5, left: 20),
                  child: Text(
                    "Lets Get Started",
                    style: GoogleFonts.montserrat(
                        fontSize: 17,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Image.asset(
                  'assets/laptopback.png',
                  height: 400,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor(global.primary_color)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      labelText: "Mobile Number",
                      labelStyle: GoogleFonts.montserrat(color: Colors.grey),
                      floatingLabelStyle: GoogleFonts.montserrat(
                          color: HexColor(global.primary_color)),
                      prefixIcon: Icon(Icons.phone_android),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (states) => states.contains(MaterialState.focused)
                            ? HexColor(global.primary_color)
                            : Colors.grey,
                      ),
                    ),
                    // controller: controller,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OTPPage(mobile_no: "8849346645")));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor(global.primary_color),

                      border: Border.all(
                          width: 2, color: HexColor(global.primary_color)),
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
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New To Tibloo? ",
                    style: GoogleFonts.montserrat(
                        fontSize: 14, color: Colors.white),
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
    );
  }
}
