import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tibloo/AuthenticationModule/LoginPage.dart';
import 'package:tibloo/HomeModule/HomePage.dart';
import 'globals.dart' as global;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences pref = await SharedPreferences.getInstance();
  var user_id = pref.getString("user_id");
  global.user_id = pref.getString("user_id").toString();
  var status = pref.getBool('isLoggedIn');
  var full_name = pref.getString("full_name");
  var first_name = pref.getString("firstname");
  var last_name = pref.getString("lastname");
  global.fullname = pref.getString("full_name").toString();
  var email = pref.getString("email");
  var contact = pref.getString("contact");
  global.contact = pref.getString("contact").toString();
  runApp(
    MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: "Tibloo",
      home: status == true ? HomePage() : LoginPage(),
    ),
  );
}
