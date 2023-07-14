import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tibloo/AuthenticationModule/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: "Tibloo",
        home: LoginPage()),
  );
}
