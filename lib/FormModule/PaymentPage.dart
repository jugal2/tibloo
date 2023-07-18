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
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  void initState() {
    super.initState();
    this.getPaymentPage();
  }

  List sop_services = [];
  List packages_data = [];
  List top_banner = [];
  int currentIndex = 0;
  List bottomInfoData = [];

  var sop_country_image_path = "";

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
        sop_country_image_path = resp['sop_country_image_path'];
        top_banner = resp['bottom_banners'];
        bottomInfoData = resp['bottom_info'];
      });
    }
    print(resp['sop_services']);
    return "Success";
  }

  Future<String> getPackages(sop_service_id, sop_country_id) async {
    print("PaymentPage Data Api Runs");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");

    // final auths = await Authorization();
    var res = await http
        .post(Uri.parse(global.api_base_url + "get_packages"), headers: {
      "Accept": "application/json",
      "Authorization": 'Bearer ' + global.authToken,
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "sop_service_id": sop_service_id,
      "sop_country_id": sop_country_id,
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
        packages_data = resp['sop_packages'];
      });
    }
    return "Success";
  }

  var selected_sop_service = "";
  var sopServiceIndex = 0;

  List<String> _locations = [
    'Please choose Employment Status',
    'A',
    'B',
    'C',
    'D'
  ]; // Option 1
  String _selectedLocation = 'Please choose Employment Status'; // Option 1

  final ImagePicker _picker = ImagePicker();
  File? uploadimage;
  Future<void> chooseImage() async {
    var choosedimage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
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
                        sop_services[0]['sop_service_name'].toString(),
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Image.network(
                        sop_country_image_path +
                            sop_services[0]["packages"][0]["country_image"],
                        height: 50,
                      ),
                    ],
                  ),
                  Text(
                    sop_services[0]['packages'][0]['country_name'].toString(),
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
                        "John Doe",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "9876543210",
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
                      "example@gmail.com",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      ' \u{20B9} ' + sop_services[0]["packages"][0]["price"],
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
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
