import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tibloo/AuthenticationModule/LoginPage.dart';
import 'package:tibloo/DataTest.dart';
import 'package:tibloo/FormModule/UploadDocumentPage.dart';
import 'package:tibloo/HomeModule/AccommodationPage.dart';
import 'package:tibloo/HomeModule/EmploymentPage.dart';
import 'package:tibloo/globals.dart' as global;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor("ffffff"),
      body: Container(
        color: HexColor("#f2f3f7"),
        padding: EdgeInsets.only(top: 40),
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/avatar.gif',
                          height: 70,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello " + global.fullname,
                            style: GoogleFonts.montserrat(
                                color: HexColor(global.primary_color),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                          ),
                          Text(
                            global.contact,
                            style: GoogleFonts.montserrat(
                              color: HexColor(global.primary_color),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilePickerDemo()));*/
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Icon(
                        Icons.close,
                        color: HexColor(global.primary_color),
                      )),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: 20),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "My Activity",
                style: GoogleFonts.montserrat(
                    color: HexColor(global.primary_color),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        color: HexColor(global.primary_color),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/paper.png',
                          height: 25,
                          color: HexColor(global.primary_color),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                        ),
                        Text(
                          "SOP",
                          style: GoogleFonts.montserrat(
                              color: HexColor(global.primary_color),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccommodationPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: HexColor(global.primary_color),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/rentp.png',
                            color: HexColor(global.primary_color),
                            height: 25,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                          ),
                          Text(
                            "Rent",
                            style: GoogleFonts.montserrat(
                                color: HexColor(global.primary_color),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmploymentPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: HexColor(global.primary_color),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/suitcase.png',
                            height: 25,
                            color: HexColor(global.primary_color),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                          ),
                          Text(
                            "Jobs",
                            style: GoogleFonts.montserrat(
                                color: HexColor(global.primary_color),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
            Container(
              alignment: Alignment.center,
              color: HexColor("#f2f3f7"),
              height: 500,
              child: Text(
                "Work In Progress",
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: HexColor(global.primary_color),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
