// import 'dart:convert';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tibloo/AuthenticationModule/LoginPage.dart';
// import 'package:tibloo/globals.dart' as global;
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:flutter/services.dart';
//
// void configLoading() {
//   EasyLoading.instance
//     ..displayDuration = const Duration(milliseconds: 2000)
//     ..indicatorType = EasyLoadingIndicatorType.ripple
//     ..loadingStyle = EasyLoadingStyle.custom
//     ..indicatorSize = 45.0
//     ..radius = 10.0
//     ..progressColor = HexColor('3d3d3d')
//     ..backgroundColor = HexColor('3d3d3d')
//     ..boxShadow = <BoxShadow>[]
//     ..indicatorColor = Colors.white
//     ..textColor = Colors.white
//     ..maskColor = Colors.green.withOpacity(0.5)
//     ..userInteractions = false
//     ..dismissOnTap = false;
//   //..customAnimation = CustomAnimation();
// }
//
// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);
//
//   @override
//   State<MainPage> createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   void initState() {
//     super.initState();
//     this.getHomePage();
//   }
//
//   List sop_services = [];
//   List packages_data = [];
//   List top_banner = [];
//   int currentIndex = 0;
//   List bottomInfoData = [];
//
//   var sop_country_image_path = "";
//
//   Future<String> getHomePage() async {
//     print("Homepage Data Api Runs");
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var user_id = pref.getString("user_id");
//     configLoading();
//     EasyLoading.show(status: 'Loading...');
//     // final auths = await Authorization();
//     var res = await http
//         .post(Uri.parse(global.api_base_url + "get_homepage_data"), headers: {
//       "Accept": "application/json",
//       "Authorization": 'Bearer ' + global.authToken,
//     }, body: {
//       "secrete": "dacb465d593bd139a6c28bb7289fa798",
//       "user_id": user_id,
//     });
//
//     var resp = json.decode(res.body);
//
//     /*  if (auths != 200) {
//       EasyLoading.dismiss();
//       final snackBar = SnackBar(
//         content: Text("Access Denied"),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     } else  */
//     if (resp['status'] == '0') {
//       EasyLoading.dismiss();
//       final snackBar = SnackBar(
//         content: Text(resp['message']),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     } else {
//       EasyLoading.dismiss();
//       setState(() {
//         sop_services = resp['sop_services'];
//         sop_country_image_path = resp['sop_country_image_path'];
//         top_banner = resp['top_banners'];
//         bottomInfoData = resp['bottom_info'];
//       });
//     }
//     print(resp['sop_services']);
//     return "Success";
//   }
//
//   Future<String> getPackages(sop_service_id, sop_country_id) async {
//     print("Homepage Data Api Runs");
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var user_id = pref.getString("user_id");
//
//     // final auths = await Authorization();
//     var res = await http
//         .post(Uri.parse(global.api_base_url + "get_packages"), headers: {
//       "Accept": "application/json",
//       "Authorization": 'Bearer ' + global.authToken,
//     }, body: {
//       "secrete": "dacb465d593bd139a6c28bb7289fa798",
//       "sop_service_id": sop_service_id,
//       "sop_country_id": sop_country_id,
//     });
//
//     var resp = json.decode(res.body);
//
//     /*  if (auths != 200) {
//       EasyLoading.dismiss();
//       final snackBar = SnackBar(
//         content: Text("Access Denied"),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     } else  */
//     if (resp['status'] == '0') {
//       EasyLoading.dismiss();
//       final snackBar = SnackBar(
//         content: Text(resp['message']),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     } else {
//       EasyLoading.dismiss();
//       setState(() {
//         packages_data = resp['sop_packages'];
//       });
//     }
//     return "Success";
//   }
//
//   var selected_sop_service = "";
//   var sopServiceIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: HexColor("3d3d3d"),
//         appBar: AppBar(
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: HexColor("3d3d3d"),
//           actions: [
//             GestureDetector(
//                 onTap: () async {
//                   SharedPreferences pref =
//                       await SharedPreferences.getInstance();
//                   pref.remove('isLoggedIn');
//                   pref.remove("user_id");
//                   pref.remove("full_name");
//                   pref.remove("contact");
//                   pref.remove("email");
//                   //_storeLoggedInStatus(true);
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                       (route) => false);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: Icon(
//                     Icons.logout,
//                     color: Colors.white,
//                   ),
//                 ))
//           ],
//           title: Image.asset(
//             'assets/TiblooWhiteC.png',
//             height: 90,
//           ),
//         ),
//         body: ListView(
//           physics: BouncingScrollPhysics(parent: ScrollPhysics()),
//           shrinkWrap: true,
//           children: [
//             Container(
//               height: 168,
//               decoration: BoxDecoration(
//                 color: HexColor("3d3d3d"),
//                 image: DecorationImage(
//                     image: AssetImage("assets/homebackground.png"),
//                     fit: BoxFit.fitWidth,
//                     alignment: Alignment.topCenter),
//               ),
//               child: Container(
//                 margin: EdgeInsets.only(left: 20, right: 20),
//                 padding: EdgeInsets.only(top: 60, bottom: 60),
//                 child: ListView(
//                   physics: BouncingScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(right: 20),
//                       padding: EdgeInsets.only(
//                           left: 10, right: 10, top: 10, bottom: 10),
//                       decoration: BoxDecoration(
//                         color: HexColor("515151"),
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                       ),
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             'assets/passport.png',
//                             height: 17,
//                             color: Colors.white,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 2),
//                           ),
//                           Text(
//                             "SOP",
//                             style: GoogleFonts.montserrat(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(right: 20),
//                       padding: EdgeInsets.only(
//                           left: 10, right: 10, top: 10, bottom: 10),
//                       decoration: BoxDecoration(
//                         color: HexColor("515151"),
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                       ),
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             'assets/home.png',
//                             height: 17,
//                             color: Colors.white,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 2),
//                           ),
//                           Text(
//                             "Accomodation",
//                             style: GoogleFonts.montserrat(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(
//                           left: 10, right: 10, top: 10, bottom: 10),
//                       decoration: BoxDecoration(
//                         color: HexColor("515151"),
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                       ),
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             'assets/service.png',
//                             height: 17,
//                             color: Colors.white,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 2),
//                           ),
//                           Text(
//                             "Employment",
//                             style: GoogleFonts.montserrat(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding:
//                   EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
//               child: Container(
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: HexColor("515151"),
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                 ),
//                 child: Text(
//                   "Select SOP service to get started",
//                   style: GoogleFonts.montserrat(
//                       color: Colors.white, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//             Container(
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: BouncingScrollPhysics(),
//                   //shrinkWrap : true,
//                   //itemCount: 2,
//                   scrollDirection: Axis.vertical,
//                   itemCount: sop_services == null ? 0 : sop_services.length,
//                   itemBuilder: (
//                     BuildContext context,
//                     int index,
//                   ) {
//                     return Container(
//                       margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                       child: Container(
//                         padding:
//                             EdgeInsets.only(bottom: 10, left: 10, right: 10),
//                         decoration: BoxDecoration(
//                           color: HexColor("515151"),
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(15),
//                           ),
//                           border: Border.all(
//                             color: HexColor("7d7d7d"),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 20.0, left: 10, bottom: 5),
//                                 child: Text(
//                                   sop_services[index]['sop_service_name']
//                                       .toString(),
//                                   style: GoogleFonts.montserrat(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 1.0, left: 10, bottom: 5),
//                                 child: Text(
//                                   "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
//                                   style: GoogleFonts.montserrat(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 150,
//                               child: ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: BouncingScrollPhysics(),
//                                   //shrinkWrap : true,
//                                   //itemCount: 2,
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: sop_services[index]['packages'] ==
//                                           null
//                                       ? 0
//                                       : sop_services[index]['packages'].length,
//                                   itemBuilder: (BuildContext context, int ind) {
//                                     return Container(
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           print("Service ID");
//                                           print(sop_services[index]
//                                               ['sop_service_id']);
//                                           print("Country ID");
//                                           print(sop_services[index]["packages"]
//                                               [ind]["id"]);
//                                           /*  getPackages(
//                                                       sop_services[index]
//                                                           ['sop_service_id'],
//                                                       sop_services[index]
//                                                               ["packages"][ind]
//                                                           ["id"]);*/
//                                         },
//                                         child: Container(
//                                           margin: EdgeInsets.only(right: 5),
//                                           decoration: BoxDecoration(
//                                             color: HexColor("3d3d3d"),
//                                             borderRadius: BorderRadius.all(
//                                               Radius.circular(8),
//                                             ),
//                                           ),
//                                           width: 120,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                     .only(
//                                                                 bottom: 5.0),
//                                                         child: Image.network(
//                                                           sop_country_image_path +
//                                                               sop_services[index]
//                                                                           [
//                                                                           "packages"]
//                                                                       [ind][
//                                                                   "country_image"],
//                                                           height: 35,
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         margin: EdgeInsets.only(
//                                                             top: 5),
//                                                         child: Text(
//                                                           sop_services[index][
//                                                                       "packages"]
//                                                                   [ind]
//                                                               ["country_name"],
//                                                           style: GoogleFonts
//                                                               .montserrat(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   fontSize: 13),
//                                                           maxLines: 2,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         margin: EdgeInsets.only(
//                                                             top: 5),
//                                                         child: Text(
//                                                           sop_services[index]
//                                                                   ["packages"]
//                                                               [ind]["name"],
//                                                           style: GoogleFonts
//                                                               .montserrat(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 13),
//                                                           maxLines: 2,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         margin: EdgeInsets.only(
//                                                             top: 5),
//                                                         child: Text(
//                                                           sop_services[index]
//                                                                   ["packages"]
//                                                               [ind]["price"],
//                                                           style: GoogleFonts
//                                                               .montserrat(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 13),
//                                                           maxLines: 2,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//             ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 scrollDirection: Axis.vertical,
//                 itemCount: top_banner == null ? 0 : top_banner?.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     margin: EdgeInsets.only(
//                       left: 10,
//                       right: 10,
//                       bottom: 10,
//                     ),
//                     height: 240,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(15),
//                       ),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: FadeInImage.assetNetwork(
//                         placeholder: global.banner_placeholder,
//                         image: top_banner[index]['image_path'],
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   );
//                 }),
//             /*Container(
//               margin: EdgeInsets.only(left: 10, right: 10),
//               height: 240,
//               child: CarouselSlider(
//                 options: CarouselOptions(
//                   aspectRatio: 1,
//                   viewportFraction: 1,
//                   enlargeCenterPage: true,
//                   autoPlay: true,
//                   onPageChanged: (index, reason) {
//                     setState(() {
//                       currentIndex = index;
//                     });
//                   },
//                 ),
//                 items: top_banner?.map((i) {
//                       return Builder(
//                         builder: (BuildContext context) {
//                           return Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(15),
//                               ),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(15),
//                               child: FadeInImage.assetNetwork(
//                                 placeholder: global.banner_placeholder,
//                                 image: i['image_path'],
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }).toList() ??
//                     [],
//               ),
//             ),*/
//             Container(
//               color: Colors.transparent,
//               child: Wrap(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10.0),
//                       ),
//                     ),
//                     height: 100,
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         physics: BouncingScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         itemCount:
//                             bottomInfoData == null ? 0 : bottomInfoData.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return GestureDetector(
//                             onTap: () {},
//                             child: Container(
//                               margin: EdgeInsets.only(top: 5),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(10.0),
//                                 ),
//                               ),
//                               padding: EdgeInsets.only(right: 15),
//                               child: Column(
//                                 children: <Widget>[
//                                   Stack(
//                                     children: <Widget>[
//                                       Container(
//                                         margin: EdgeInsets.only(
//                                           left: 10.0,
//                                         ),
//                                         child: Image.network(
//                                           bottomInfoData[index]['image_path'],
//                                           color: Colors.white.withOpacity(0.6),
//                                           height: 60,
//                                           width: 60,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Container(
//                                     //child:Expanded(
//                                     alignment: Alignment.center,
//                                     padding: EdgeInsets.only(
//                                       right: 10,
//                                       left: 10,
//                                     ),
//                                     child: Text(
//                                       bottomInfoData[index]['title'],
//                                       style: GoogleFonts.montserrat(
//                                         textStyle: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 11,
//                                         ),
//                                       ),
//                                       maxLines: 2,
//                                       textAlign: TextAlign.center,
//                                       //textDirection: TextDirection.ltr,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(padding: EdgeInsets.only(bottom: 20))
//           ],
//         ),
//       ),
//     );
//   }
// }
