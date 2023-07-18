import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tibloo/AuthenticationModule/LoginPage.dart';
import 'package:tibloo/HomeModule/AccommodationPage.dart';
import 'package:tibloo/HomeModule/EmploymentPage.dart';
import 'package:tibloo/HomeModule/HomePage.dart';
import 'package:tibloo/ThankYouPage.dart';
import 'package:tibloo/globals.dart' as global;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ripple
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = HexColor('3d3d3d')
    ..backgroundColor = HexColor('3d3d3d')
    ..boxShadow = <BoxShadow>[]
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.green.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

class PaymentPage extends StatefulWidget {
  final String? application_id;
  const PaymentPage({
    Key? key,
    this.application_id,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  void initState() {
    super.initState();
    this.getPaymentPage();
    this.getPackageDetails();
  }

  List sop_services = [];
  List packages_data = [];
  List top_banner = [];
  int currentIndex = 0;
  List bottomInfoData = [];

  var sop_country_image_path = "";
  var country_name = "";
  var applicant_name = "";
  var contact = "";
  var email = "";
  var package_price = "";
  var package_name = "";
  var service_name = "";

  Future<String> getPaymentPage() async {
    print("PaymentPage Data Api Runs");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");
    configLoading();
    EasyLoading.show(status: 'Loading...');
    // final auths = await Authorization();
    var res = await http
        .post(Uri.parse(global.api_base_url + "get_homepage_data"), headers: {
      "Accept": "application/json",
      "Authorization": 'Bearer ' + global.authToken,
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": user_id,
    });

    var resp = json.decode(res.body);

    /*  if (auths != 200) {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text("Access Denied"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else  */
    if (resp['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(resp['message']),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        sop_services = resp['sop_services'];
        top_banner = resp['bottom_banners'];
        bottomInfoData = resp['bottom_info'];
      });
    }
    print(resp['sop_services']);
    return "Success";
  }

  Future<String> getPackageDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");

    // final auths = await Authorization();
    var res = await http.post(
      Uri.parse(global.api_base_url + "confirm_sop_package_details"),
      headers: {
        "Accept": "application/json",
        "Authorization": 'Bearer ' + global.authToken,
      },
      body: {
        "secrete": "dacb465d593bd139a6c28bb7289fa798",
        "application_id": widget.application_id,
      },
    );

    var resp = json.decode(res.body);

    /*  if (auths != 200) {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text("Access Denied"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else  */
    if (resp['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(resp['message']),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        sop_country_image_path = resp['country_image'];
        country_name = resp['country_name'];
        applicant_name = resp['applicant_name'];
        contact = resp['contact'];
        email = resp['email'];
        package_price = resp['package_price'];
        package_name = resp['package_name'];
        service_name = resp['service_name'];
      });
    }
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor(global.primary_color),
          elevation: 0,
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(
            color: HexColor(global.primary_color),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: HexColor(global.secondary_color),

                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    // color: HexColor(global.secondary_color),
                  ),
                  height: 40,
                  width: 80,
                  child: Center(
                    child: Text(
                      "Back",
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
          height: 60,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 28, right: 28, top: 20),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: HexColor(global.primary_color).withOpacity(.2),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/applicantform.png',
                          height: 50,
                        ),
                        Text(
                          "Step-1",
                          style: GoogleFonts.montserrat(
                            color: HexColor(global.primary_color),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: HexColor(global.primary_color),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      height: 5,
                      width: 70,
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/uploadformblue.png',
                          height: 50,
                        ),
                        Text(
                          "Step-2",
                          style: GoogleFonts.montserrat(
                            color: HexColor(global.primary_color),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: HexColor(global.primary_color),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      height: 5,
                      width: 70,
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/paymentblue.png',
                          height: 50,
                        ),
                        Text(
                          "Step-3",
                          style: GoogleFonts.montserrat(
                            color: HexColor(global.primary_color),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 28, right: 28, top: 20),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: HexColor(global.secondary_color).withOpacity(.5),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  "Payment Information",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: HexColor(global.primary_color).withOpacity(.8)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: HexColor(global.primary_color),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        service_name,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Image.network(
                        sop_country_image_path,
                        height: 50,
                      ),
                    ],
                  ),
                  Text(
                    country_name,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Divider(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        applicant_name,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        contact,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      email,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Text(
                      package_name,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      ' \u{20B9} ' + package_price,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      global.employment_certificate_path = null;
                      global.passport_copy_path = null;
                      global.course_certificate_path = null;
                      global.training_course_path = null;
                      global.marriage_certificate_path = null;
                      global.ielts_certificate_path = null;
                      global.offer_letter_path = null;
                      global.loan_letter_path = null;
                      global.tuition_fee_receiept_path = null;
                      global.fund_related_doc_path = null;
                      global.extra_curriculum_path = null;
                      global.any_remark_path = null;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ThankYouPage()));
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: HexColor(global.secondary_color),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 30, left: 80, right: 80),
                      child: Text(
                        "Pay",
                        style: GoogleFonts.montserrat(
                          color: HexColor(global.primary_color),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
