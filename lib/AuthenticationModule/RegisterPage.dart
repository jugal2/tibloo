import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tibloo/AuthenticationModule/LoginPage.dart';
import 'package:tibloo/AuthenticationModule/OTPPage.dart';
import 'package:tibloo/globals.dart' as global;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 60),
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
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "First Name",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor(global.primary_color)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelStyle: GoogleFonts.montserrat(color: Colors.grey),
                    floatingLabelStyle: GoogleFonts.montserrat(
                        color: HexColor(global.primary_color)),
                    prefixIcon: Icon(Icons.person_2),
                    prefixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                          ? HexColor(global.primary_color)
                          : Colors.grey,
                    ),
                  ),
                  // controller: controller,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Last Name",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor(global.primary_color)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelStyle: GoogleFonts.montserrat(color: Colors.grey),
                    floatingLabelStyle: GoogleFonts.montserrat(
                        color: HexColor(global.primary_color)),
                    prefixIcon: Icon(Icons.person_2_outlined),
                    prefixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                          ? HexColor(global.primary_color)
                          : Colors.grey,
                    ),
                  ),
                  // controller: controller,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Email",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor(global.primary_color)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelStyle: GoogleFonts.montserrat(color: Colors.grey),
                    floatingLabelStyle: GoogleFonts.montserrat(
                        color: HexColor(global.primary_color)),
                    prefixIcon: Icon(Icons.email_outlined),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
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
                      "Register",
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
                  "Joined us before? ",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: HexColor(global.primary_color),
                      fontSize: 14,
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
    );
  }
}
