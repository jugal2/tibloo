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

class ApplicantFormPage extends StatefulWidget {
  final String? package_id;
  const ApplicantFormPage({
    Key? key,
    this.package_id,
  }) : super(key: key);

  @override
  State<ApplicantFormPage> createState() => _ApplicantFormPageState();
}

class _ApplicantFormPageState extends State<ApplicantFormPage> {
  void initState() {
    super.initState();
    this.getApplicantFormPage();
  }

  List sop_services = [];
  List packages_data = [];
  List top_banner = [];
  int currentIndex = 0;
  List bottomInfoData = [];
  var application_id = "";

  var sop_country_image_path = "";

  Future<String> getApplicantFormPage() async {
    print("ApplicantFormPage Data Api Runs");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");
    configLoading();
    EasyLoading.show(status: 'Loading...');
    // final auths = await Authorization();
    var res = await http.post(
        Uri.parse(global.api_base_url + "get_ApplicantFormPage_data"),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer ' + global.authToken,
        },
        body: {
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

  Future<void> sopServiceStepOneUpdate() async {
    configLoading();
    EasyLoading.show(status: 'Loading...');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");

    var sop_service_step_one =
        global.api_base_url + "sop_service_step_one_update";
    var res = await http.post(Uri.parse(sop_service_step_one), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "application_id": application_id,
      "applicant_name": applicantNameController.text,
      "contact": contactNumberController.text,
      "email": emailController.text,
      "father_name": fatherNameController.text,
      "father_company_name": fatherCompanyNameController.text,
      "father_employment_status": "1",
      "father_designation": fatherDesignationController.text,
      "mother_name": motherNameController.text,
      "mother_company_name": motherCompanyNameController.text,
      "mother_employment_status": "2",
      "mother_designation": motherDesignationController.text,
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

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadDocumentPage(
            application_id: application_id,
          ),
        ),
      );
    }
  }

  Future<void> sopServiceStepOne() async {
    configLoading();
    EasyLoading.show(status: 'Loading...');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");

    var sop_service_step_one = global.api_base_url + "sop_service_step_one";
    var res = await http.post(Uri.parse(sop_service_step_one), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": user_id,
      "package_id": widget.package_id,
      "applicant_name": applicantNameController.text,
      "contact": contactNumberController.text,
      "email": emailController.text,
      "father_name": fatherNameController.text,
      "father_company_name": fatherCompanyNameController.text,
      "father_employment_status": "1",
      "father_designation": fatherDesignationController.text,
      "mother_name": motherNameController.text,
      "mother_company_name": motherCompanyNameController.text,
      "mother_employment_status": "2",
      "mother_designation": motherDesignationController.text,
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
      application_id = resp['application_id'].toString();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UploadDocumentPage(application_id: application_id),
        ),
      );
    }
  }

  Future<String> getPackages(sop_service_id, sop_country_id) async {
    print("ApplicantFormPage Data Api Runs");
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

  TextEditingController applicantNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController fatherCompanyNameController = TextEditingController();
  TextEditingController fatherDesignationController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController motherCompanyNameController = TextEditingController();
  TextEditingController motherDesignationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
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
              Container(
                decoration: BoxDecoration(
                  color: HexColor(global.primary_color),
                  border: Border.all(
                    color: HexColor(global.secondary_color),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  // color: HexColor(global.secondary_color),
                ),
                height: 40,
                width: 110,
                child: Center(
                  child: Text(
                    "Save Draft",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (application_id == "") {
                    sopServiceStepOne();
                  } else {
                    sopServiceStepOneUpdate();
                  }
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
                      "Next",
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
                        color: Colors.black.withOpacity(0.3),
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
                          'assets/uploadformgray.png',
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
                        color: Colors.black.withOpacity(0.3),
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
                          'assets/paymentgray.png',
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
                  "Applicant Form",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: HexColor(global.primary_color).withOpacity(.8)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: applicantNameController,
                style: GoogleFonts.montserrat(
                    color: HexColor(global.primary_color)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  labelText: "Applicant Name",
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                maxLength: 10,
                controller: contactNumberController,
                style: GoogleFonts.montserrat(
                    color: HexColor(global.primary_color)),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  labelText: "Contact Number",
                  labelStyle: GoogleFonts.montserrat(
                      color: HexColor(global.primary_color)),
                  floatingLabelStyle: GoogleFonts.montserrat(
                      color: HexColor(global.primary_color)),
                  prefixIcon: Icon(Icons.phone_outlined),
                  prefixIconColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.focused)
                        ? HexColor(global.primary_color)
                        : HexColor(global.primary_color),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: emailController,
                style: GoogleFonts.montserrat(
                    color: HexColor(global.primary_color)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  labelText: "Email",
                  labelStyle: GoogleFonts.montserrat(
                      color: HexColor(global.primary_color)),
                  floatingLabelStyle: GoogleFonts.montserrat(
                      color: HexColor(global.primary_color)),
                  prefixIcon: Icon(Icons.mail_outline_rounded),
                  prefixIconColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.focused)
                        ? HexColor(global.primary_color)
                        : HexColor(global.primary_color),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: fatherNameController,
                style: GoogleFonts.montserrat(
                    color: HexColor(global.primary_color)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  labelText: "Father Name",
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
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              margin: EdgeInsets.only(left: 28, right: 28, top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: HexColor(global.primary_color))),
              child: DropdownButton(
                isExpanded: true, //make true to take width of parent widget
                underline: Container(), //empty line
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 15, color: HexColor(global.primary_color))),
                dropdownColor: Colors.white,
                iconEnabledColor: HexColor(global.primary_color), //Icon color
                padding: EdgeInsets.only(left: 20, right: 20),
                hint: Text(
                    'Please choose Employment Status'), // Not necessary for Option 1
                value: _selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue!;
                  });
                },
                items: _locations.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: fatherCompanyNameController,
                style: GoogleFonts.montserrat(
                    color: HexColor(global.primary_color)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  labelText: "Company Name",
                  labelStyle: GoogleFonts.montserrat(
                      color: HexColor(global.primary_color)),
                  floatingLabelStyle: GoogleFonts.montserrat(
                      color: HexColor(global.primary_color)),
                  prefixIcon: Icon(Icons.cases_outlined),
                  prefixIconColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.focused)
                        ? HexColor(global.primary_color)
                        : HexColor(global.primary_color),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: fatherDesignationController,
                style: GoogleFonts.montserrat(
                    color: HexColor(global.primary_color)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  labelText: "Designation",
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: motherNameController,
                style: GoogleFonts.montserrat(
                    color: HexColor(global.primary_color)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  labelText: "Mother Name",
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
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              margin: EdgeInsets.only(left: 28, right: 28, top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: HexColor(global.primary_color))),
              child: DropdownButton(
                isExpanded: true, //make true to take width of parent widget
                underline: Container(), //empty line
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 15, color: HexColor(global.primary_color))),
                dropdownColor: Colors.white,
                iconEnabledColor: HexColor(global.primary_color), //Icon color
                padding: EdgeInsets.only(left: 20, right: 20),
                hint: Text(
                    'Please choose Employment Status'), // Not necessary for Option 1
                value: _selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue!;
                  });
                },
                items: _locations.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: motherCompanyNameController,
                style: GoogleFonts.montserrat(
                    color: HexColor(global.primary_color)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  labelText: "Company Name",
                  labelStyle: GoogleFonts.montserrat(
                      color: HexColor(global.primary_color)),
                  floatingLabelStyle: GoogleFonts.montserrat(
                      color: HexColor(global.primary_color)),
                  prefixIcon: Icon(Icons.cases_outlined),
                  prefixIconColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.focused)
                        ? HexColor(global.primary_color)
                        : HexColor(global.primary_color),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: motherDesignationController,
                style: GoogleFonts.montserrat(
                    color: HexColor(global.primary_color)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(global.primary_color)),
                  ),
                  labelText: "Designation",
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
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 80),
            ),
          ],
        ),
      ),
    );
  }
}
