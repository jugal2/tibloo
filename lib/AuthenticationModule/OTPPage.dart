import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tibloo/globals.dart' as global;

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
    return Scaffold(
      body: Column(
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
                    color: Colors.black,
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
                  color: Colors.black45,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "+${widget.mobile_no}",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Form(
            key: formKey,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 9.0, horizontal: 40),
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
                    activeColor: HexColor(global.primary_color),
                    /////INACTIVE////
                    inactiveColor: Colors.grey,
                    /////INACTIVE////
                    selectedColor: HexColor(global.secondary_color),
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 45,
                    fieldWidth: 45,
                    activeFillColor: Colors.white,
                  ),
                  autoFocus: true,
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: false,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,

                  onCompleted: (v) {
                    print("otp verification api hit");
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
                    dialogContent: "Do You Want To Paste " + _otp.toString(),
                    affirmativeText: "Yes",
                  ),
                  // beforeTextPaste: (_) => false,
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $_otp");

                    return true;
                  },
                )),
          ),
        ],
      ),
    );
  }
}
