import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tibloo/AuthenticationModule/LoginPage.dart';
import 'package:tibloo/HomeModule/HomePage.dart';
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

class OTPPage extends StatefulWidget {
  final String mobile_no;
  const OTPPage({Key? key, required this.mobile_no}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  static String? _otp;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(this.context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: HexColor(global.primary_color),
        body: Stack(
          children: [
            Positioned.fill(
              top: 60,
              child: Image.asset(
                'assets/blobreg.png',
                color: Colors.white,
                alignment: Alignment.topRight,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 100)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                    ),
                    Text(
                      "OTP Verification",
                      style: GoogleFonts.montserrat(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "Please enter the 6-digit OTP sent to",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: HexColor(global.secondary_color),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  child: Row(
                    children: [
                      Text(
                        "+${widget.mobile_no}",
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: HexColor(global.secondary_color),
                            fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          " Edit",
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 9.0, horizontal: 40),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,

                        animationType: AnimationType.scale,
                        /*validator: (v) {
                              if (v!.length < 3) {
                                return "I'm from validator";
                              } else {
                                return null;
                              }
                            },*/
                        pinTheme: PinTheme(
                          borderWidth: 1,
                          borderRadius: BorderRadius.circular(5),
                          ////ACTIVE//////
                          activeColor: Colors.white,
                          /////INACTIVE////
                          inactiveColor: Colors.white60,
                          /////INACTIVE////
                          selectedColor: HexColor(global.secondary_color),
                          shape: PinCodeFieldShape.box,
                          fieldHeight: 45,
                          fieldWidth: 45,
                          activeFillColor: Colors.black,
                        ),
                        autoFocus: true,
                        cursorColor: Colors.white,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: false,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        textStyle: GoogleFonts.montserrat(color: Colors.white),
                        onCompleted: (v) {
                          // otpVerification(context, _otp);
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        enablePinAutofill: true,
                        dialogConfig: DialogConfig(
                          dialogTitle: "Tibloo",
                          dialogContent:
                              "Do You Want To Paste " + _otp.toString(),
                          affirmativeText: "Yes",
                        ),
                        // beforeTextPaste: (_) => false,
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $_otp");

                          return true;
                        },
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    otpVerification(context, _otp);
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
                        "Verify",
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
          ],
        ),
      ),
    );
  }

  Future<void> otpVerification(context, _otp) async {
    configLoading();
    EasyLoading.show(status: 'Loading...');
    print('mobile_no=' + widget.mobile_no);
    // print('otp method =' + _otp);
    var otp_login_url = global.api_base_url + "verify_otp";
    var res = await http.post(Uri.parse(otp_login_url), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "contact": widget.mobile_no,
      "otp": textEditingController.text,
    });
    var resp = json.decode(res.body);
    print(resp);
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
      print(resp);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool('isLoggedIn', true);
      pref.setString("user_id", resp['user_id']);
      pref.setString("full_name", resp['full_name']);
      pref.setString("firstname", resp['firstname']);
      pref.setString("lastname", resp['lastname']);
      pref.setString("email", resp['email']);
      pref.setString("contact", resp['contact']);
      global.user_id = resp['user_id'];
      global.fullname = resp['full_name'];
      global.first_name = resp['firstname'];
      global.last_name = resp['lastname'];
      global.email = resp['email'];
      global.contact = resp['contact'];

      print("User Id = " + global.user_id);
      // SendPushNotification();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
