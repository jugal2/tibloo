import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tibloo/HomeModule/HomePage.dart';
import 'package:tibloo/globals.dart' as global;

class ThankYouPage extends StatefulWidget {
  @override
  _ThankYouPageState createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#fafcfb"),
      // appBar: TopjecAppbarBack(context),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Material(
          child: Container(color: HexColor("#fafcfb"), child: Thank_You()),
        ),
      ),
    );
  }
}

class Thank_You extends StatefulWidget {
  @override
  _Thank_YouState createState() => _Thank_YouState();
}

class _Thank_YouState extends State<Thank_You> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            child: Image.asset(
              'assets/checkgif.gif',
              height: 400,
              width: 400,
            ),
          ),
        ),
        Container(
          child: Center(
            child: Text(
              "Congratulation",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            child: Center(
              child: Text(
                "Your request has been submitted successfully.",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            child: Center(
              child: Text(
                "Thank you for using Tibloo.",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(this.context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: HexColor(global.secondary_color),
            ),
            margin: EdgeInsets.only(left: 90, right: 90, top: 40),
            height: 50,
            child: Center(
                child: Text(
              "Back To Home",
              style: GoogleFonts.montserrat(
                  fontSize: 17, color: HexColor(global.primary_color)),
            )),
          ),
        ),
      ],
    );
  }
}
