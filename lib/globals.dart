library my_prj.globals;

import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tibloo/AuthenticationModule/LoginPage.dart';
import 'package:tibloo/FormModule/PaymentPage.dart';
import 'package:tibloo/HomeModule/AccommodationPage.dart';
import 'package:tibloo/HomeModule/EmploymentPage.dart';
import 'package:tibloo/globals.dart' as global;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

String background_color = "f4f4f4";
// String primary_color = "3a7fc0";
String banner_placeholder = "assets/Placeholder/banner_placeholder.jpg";
String auth_api_url = "https://tibloo.graphionicinfotech.com/authapi/";
String authEmail = "graphionic@gmail.com";
String authPassword = "Graphionic@1801";
String authToken = "";
String api_base_url = "https://tibloo.graphionicinfotech.com/api/";
String primary_color = "253646";
String secondary_color = "fdc102";

String user_id = "";
String first_name = "";
String last_name = "";
String fullname = "";
String email = "";
String contact = "";

File? employment_certificate_path;
File? passport_copy_path;
File? course_certificate_path;
File? training_course_path;
File? marriage_certificate_path;
File? ielts_certificate_path;
File? offer_letter_path;
File? loan_letter_path;
File? tuition_fee_receiept_path;
File? fund_related_doc_path;
File? extra_curriculum_path;
File? any_remark_path;
