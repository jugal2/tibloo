import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tibloo/AuthenticationModule/LoginPage.dart';
import 'package:tibloo/HomeModule/AccommodationPage.dart';
import 'package:tibloo/HomeModule/EmploymentPage.dart';
import 'package:tibloo/HomeModule/HomePage.dart';
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

class AccommodationPage extends StatefulWidget {
  const AccommodationPage({Key? key}) : super(key: key);

  @override
  State<AccommodationPage> createState() => _AccommodationPageState();
}

class _AccommodationPageState extends State<AccommodationPage> {
  void initState() {
    super.initState();
    this.getAccommodationPage();
  }

  List sop_services = [];
  List packages_data = [];
  List top_banner = [];
  int currentIndex = 0;
  List bottomInfoData = [];

  var sop_country_image_path = "";

  Future<String> getAccommodationPage() async {
    print("AccommodationPage Data Api Runs");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");
    configLoading();
    EasyLoading.show(status: 'Loading...');
    // final auths = await Authorization();
    var res = await http.post(
        Uri.parse(global.api_base_url + "get_AccommodationPage_data"),
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

  Future<String> getPackages(sop_service_id, sop_country_id) async {
    print("AccommodationPage Data Api Runs");
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor("e4e4e4"),
        body: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    opacity: 0.5,
                    image: AssetImage(
                      "assets/WhiteBackground.png",
                    ),
                    fit: BoxFit.cover,
                    alignment: Alignment.center),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Image.asset(
                        'assets/user.png',
                        height: 30,
                        color: HexColor(global.primary_color),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 100),
                        child: Image.asset(
                          'assets/Tibloo.png',
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Image.asset(
                      'assets/notification.png',
                      color: HexColor(global.primary_color),
                      height: 25,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: HexColor(global.primary_color),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 50, right: 20, top: 10, bottom: 10),
                    height: 90,
                    decoration: BoxDecoration(
                      color: HexColor(global.primary_color),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/doc.png',
                                  height: 50,
                                  opacity: const AlwaysStoppedAnimation(.5),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                Text(
                                  "SOP",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white.withOpacity(.5),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/rent.png',
                                  height: 50,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                Text(
                                  "Accommodation",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 15,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/emp.png',
                                  height: 50,
                                  opacity: const AlwaysStoppedAnimation(.5),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                Text(
                                  "Employment",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white.withOpacity(.5),
                                      fontSize: 15,
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
                  ),
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        //shrinkWrap : true,
                        //itemCount: 2,
                        scrollDirection: Axis.vertical,
                        itemCount:
                            sop_services == null ? 0 : sop_services.length,
                        itemBuilder: (
                          BuildContext context,
                          int index,
                        ) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: HexColor(global.primary_color),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                /*  image: DecorationImage(
                                image: NetworkImage(
                                    sop_services[index]['image_path']),
                                fit: BoxFit.contain,
                                alignment: Alignment.topRight),*/
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10, bottom: 1),
                                      child: Text(
                                        "Select The package For ",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          sop_services[index]
                                                  ['sop_service_name']
                                              .toString(),
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                        size: 40,
                                      )
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          HexColor("f4f4f4").withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    height: 120,
                                    padding: EdgeInsets.all(20),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        //shrinkWrap : true,
                                        //itemCount: 2,

                                        scrollDirection: Axis.horizontal,
                                        itemCount: sop_services[index]
                                                    ['packages'] ==
                                                null
                                            ? 0
                                            : sop_services[index]['packages']
                                                .length,
                                        itemBuilder:
                                            (BuildContext context, int ind) {
                                          return Container(
                                            margin: EdgeInsets.only(right: 20),
                                            child: GestureDetector(
                                              onTap: () {
                                                print("Service ID");
                                                print(sop_services[index]
                                                    ['sop_service_id']);
                                                print("Country ID");
                                                print(sop_services[index]
                                                    ["packages"][ind]["id"]);
                                                /*  getPackages(
                                                        sop_services[index]
                                                            ['sop_service_id'],
                                                        sop_services[index]
                                                                ["packages"][ind]
                                                            ["id"]);*/
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        "assets/homebackground.png",
                                                      ),
                                                      fit: BoxFit.fill,
                                                      alignment: Alignment
                                                          .bottomCenter),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                ),
                                                width: 150,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  8),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 6,
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  sop_services[index]
                                                                              [
                                                                              "packages"]
                                                                          [ind][
                                                                      "country_name"],
                                                                  style: GoogleFonts.montserrat(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          13),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 1,
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  sop_services[
                                                                              index]
                                                                          [
                                                                          "packages"]
                                                                      [
                                                                      ind]["price"],
                                                                  style: GoogleFonts.montserrat(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          13),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 5,
                                                                        bottom:
                                                                            5.0,
                                                                        right:
                                                                            10),
                                                                    child: Image
                                                                        .network(
                                                                      sop_country_image_path +
                                                                          sop_services[index]["packages"][ind]
                                                                              [
                                                                              "country_image"],
                                                                      height:
                                                                          30,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: HexColor(global
                                                            .primary_color),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 1),
                                                        child: Text(
                                                          sop_services[index]
                                                                  ["packages"]
                                                              [ind]["name"],
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        padding: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/WhiteBackground.png"),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                        ),
                        child: Text(
                          "Explore More",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: HexColor(global.primary_color)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 30, bottom: 20),
                        height: 150,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 3,
                            viewportFraction: 1,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                          items: top_banner?.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: 360,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          i['image_path'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList() ??
                              [],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Image.asset('assets/bottomgif.gif'))),
                  Padding(padding: EdgeInsets.only(top: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
