import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tibloo/globals.dart' as global;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi,Welcome To Tibloo",
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ),
          GestureDetector(
            onTap: () {
              /* Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));*/
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
                  "Sign In",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              /* Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));*/
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
          ),
        ],
      ),
    );
  }
}
