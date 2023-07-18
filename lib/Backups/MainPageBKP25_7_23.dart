// import 'dart:convert';
//
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
//     ..progressColor = HexColor(global.secondary_color)
//     ..backgroundColor = HexColor(global.secondary_color)
//     ..boxShadow = <BoxShadow>[]
//     ..indicatorColor = HexColor(global.primary_color)
//     ..textColor = HexColor(global.primary_color)
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
//
//         sopServiceIndex = sop_services.length + 1;
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
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: HexColor(global.primary_color),
//           actions: [
//             GestureDetector(
//                 onTap: () async {
//                   SharedPreferences pref =
//                   await SharedPreferences.getInstance();
//                   pref.remove('isLoggedIn');
//                   pref.remove("user_id");
//                   pref.remove("full_name");
//                   pref.remove("contact");
//                   pref.remove("email");
//                   //_storeLoggedInStatus(true);
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                           (route) => false);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: Icon(
//                     Icons.logout,
//                     color: Colors.white,
//                   ),
//                 ))
//           ],
//           title: Text(
//             "Tibloo",
//             style: GoogleFonts.montserrat(
//               fontSize: 20,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         body: ListView(
//           physics: BouncingScrollPhysics(parent: ScrollPhysics()),
//           shrinkWrap: true,
//           children: [
//             Container(
//               height: 168,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 image: DecorationImage(
//                     image: AssetImage("assets/homebackground.png"),
//                     fit: BoxFit.fitWidth,
//                     alignment: Alignment.topCenter),
//               ),
//               child: Container(
//                 margin: EdgeInsets.only(left: 20, right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(
//                           left: 10, right: 10, top: 10, bottom: 10),
//                       decoration: BoxDecoration(
//                         color: HexColor(global.primary_color),
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
//                       padding: EdgeInsets.only(
//                           left: 10, right: 10, top: 10, bottom: 10),
//                       decoration: BoxDecoration(
//                         color: HexColor(global.primary_color),
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
//                         color: HexColor(global.primary_color),
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
//               EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
//               child: Container(
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: HexColor("DCDDF8"),
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                 ),
//                 child: Text(
//                   "Select SOP service to get started",
//                   style: GoogleFonts.montserrat(
//                       color: HexColor(global.primary_color)),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(
//                 bottom: 20,
//               ),
//               padding: EdgeInsets.only(top: 10, bottom: 20),
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: BouncingScrollPhysics(),
//                   //shrinkWrap : true,
//                   //itemCount: 2,
//                   scrollDirection: Axis.vertical,
//                   itemCount: sop_services == null ? 0 : sop_services.length,
//                   itemBuilder: (
//                       BuildContext context,
//                       int index,
//                       ) {
//                     return Container(
//                       height: 150,
//                       margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(.5),
//                               blurRadius: 20.0, // soften the shadow
//                               spreadRadius: 0.0, //extend the shadow
//                               offset: Offset(
//                                 5.0, // Move to right 10  horizontally
//                                 5.0, // Move to bottom 10 Vertically
//                               ),
//                             )
//                           ],
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(15),
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             IntrinsicHeight(
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width: 110,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(15)),
//                                     ),
//                                     child: Stack(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 40.0, left: 30),
//                                           child: Text(
//                                             sop_services[index]
//                                             ['sop_service_name']
//                                                 .toString(),
//                                             style: GoogleFonts.poppins(
//                                                 fontSize: 13,
//                                                 fontWeight: FontWeight.bold),
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.only(top: 60),
//                                           child: ClipRRect(
//                                             borderRadius: BorderRadius.only(
//                                                 bottomLeft:
//                                                 Radius.circular(10)),
//                                             child: Image.network(
//                                               sop_services[index]['image_path'],
//                                               height: 90,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   VerticalDivider(
//                                     color: Colors.grey.shade100,
//                                     thickness: 1,
//                                   ),
//                                   Flexible(
//                                     child: Container(
//                                       height: 150,
//                                       width: 270,
//                                       child: ListView.builder(
//                                           shrinkWrap: true,
//                                           physics: BouncingScrollPhysics(),
//                                           //shrinkWrap : true,
//                                           //itemCount: 2,
//                                           scrollDirection: Axis.horizontal,
//                                           itemCount: sop_services[index]
//                                           ['packages'] ==
//                                               null
//                                               ? 0
//                                               : sop_services[index]['packages']
//                                               .length,
//                                           itemBuilder:
//                                               (BuildContext context, int ind) {
//                                             return Container(
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   print("Service ID");
//                                                   print(sop_services[index]
//                                                   ['sop_service_id']);
//                                                   print("Country ID");
//                                                   print(sop_services[index]
//                                                   ["packages"][ind]["id"]);
//                                                   /*  getPackages(
//                                                       sop_services[index]
//                                                           ['sop_service_id'],
//                                                       sop_services[index]
//                                                               ["packages"][ind]
//                                                           ["id"]);*/
//                                                 },
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                     BorderRadius.all(
//                                                         Radius.circular(8)),
//                                                   ),
//                                                   width: 90,
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .center,
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                         children: [
//                                                           Column(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                             children: [
//                                                               Padding(
//                                                                 padding:
//                                                                 const EdgeInsets
//                                                                     .only(
//                                                                     bottom:
//                                                                     5.0),
//                                                                 child: Image
//                                                                     .network(
//                                                                   sop_country_image_path +
//                                                                       sop_services[index]["packages"]
//                                                                       [
//                                                                       ind]
//                                                                       [
//                                                                       "country_image"],
//                                                                   height: 35,
//                                                                 ),
//                                                               ),
//                                                               Container(
//                                                                 margin: EdgeInsets
//                                                                     .only(
//                                                                     top: 5),
//                                                                 child: Text(
//                                                                   sop_services[index]
//                                                                   [
//                                                                   "packages"]
//                                                                   [ind][
//                                                                   "country_name"],
//                                                                   style: GoogleFonts.poppins(
//                                                                       color: HexColor(
//                                                                           "363CC0"),
//                                                                       fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                       fontSize:
//                                                                       13),
//                                                                   maxLines: 2,
//                                                                   overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                                 ),
//                                                               ),
//                                                               Container(
//                                                                 margin: EdgeInsets
//                                                                     .only(
//                                                                     top: 5),
//                                                                 child: Text(
//                                                                   sop_services[
//                                                                   index]
//                                                                   [
//                                                                   "packages"]
//                                                                   [
//                                                                   ind]["name"],
//                                                                   style: GoogleFonts.poppins(
//                                                                       color: HexColor(
//                                                                           "363CC0"),
//                                                                       fontSize:
//                                                                       13),
//                                                                   maxLines: 2,
//                                                                   overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                                 ),
//                                                               ),
//                                                               Container(
//                                                                 margin: EdgeInsets
//                                                                     .only(
//                                                                     top: 5),
//                                                                 child: Text(
//                                                                   sop_services[
//                                                                   index]
//                                                                   [
//                                                                   "packages"]
//                                                                   [
//                                                                   ind]["price"],
//                                                                   style: GoogleFonts.poppins(
//                                                                       color: HexColor(
//                                                                           "363CC0"),
//                                                                       fontSize:
//                                                                       13),
//                                                                   maxLines: 2,
//                                                                   overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           }),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
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
//                       BuildContext context,
//                       int index,
//                       ) {
//                     return Container(
//                       margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                       child: Container(
//                         padding:
//                         EdgeInsets.only(bottom: 10, left: 10, right: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(.5),
//                               blurRadius: 20.0, // soften the shadow
//                               spreadRadius: 0.0, //extend the shadow
//                               offset: Offset(
//                                 5.0, // Move to right 10  horizontally
//                                 5.0, // Move to bottom 10 Vertically
//                               ),
//                             )
//                           ],
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(15),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(15)),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 20.0, left: 10, bottom: 10),
//                                 child: Text(
//                                   sop_services[index]['sop_service_name']
//                                       .toString(),
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.bold),
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
//                                       null
//                                       ? 0
//                                       : sop_services[index]['packages'].length,
//                                   itemBuilder: (BuildContext context, int ind) {
//                                     return Container(
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           print("Service ID");
//                                           print(sop_services[index]
//                                           ['sop_service_id']);
//                                           print("Country ID");
//                                           print(sop_services[index]["packages"]
//                                           [ind]["id"]);
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
//                                               image: DecorationImage(
//                                                   image: AssetImage(
//                                                       "assets/containerback.jpeg"),
//                                                   fit: BoxFit.fill,
//                                                   alignment: Alignment.center),
//                                               borderRadius: BorderRadius.all(
//                                                 Radius.circular(8),
//                                               ),
//                                               border: Border.all(
//                                                   color: Colors.grey.shade300)),
//                                           width: 120,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                                 children: [
//                                                   Column(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .center,
//                                                     children: [
//                                                       Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .only(
//                                                             bottom: 5.0),
//                                                         child: Image.network(
//                                                           sop_country_image_path +
//                                                               sop_services[index]
//                                                               [
//                                                               "packages"]
//                                                               [ind][
//                                                               "country_image"],
//                                                           height: 35,
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         margin: EdgeInsets.only(
//                                                             top: 5),
//                                                         child: Text(
//                                                           sop_services[index][
//                                                           "packages"]
//                                                           [ind]
//                                                           ["country_name"],
//                                                           style: GoogleFonts
//                                                               .poppins(
//                                                               color: HexColor(
//                                                                   "363CC0"),
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .bold,
//                                                               fontSize: 13),
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
//                                                           ["packages"]
//                                                           [ind]["name"],
//                                                           style: GoogleFonts
//                                                               .poppins(
//                                                               color: HexColor(
//                                                                   "363CC0"),
//                                                               fontSize: 13),
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
//                                                           ["packages"]
//                                                           [ind]["price"],
//                                                           style: GoogleFonts
//                                                               .poppins(
//                                                               color: HexColor(
//                                                                   "363CC0"),
//                                                               fontSize: 13),
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
//           ],
//         ),
//       ),
//       /*  Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           image: DecorationImage(
//               image: AssetImage("assets/homebackground.png"),
//               fit: BoxFit.fitWidth,
//               alignment: Alignment.topCenter),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Wrap(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(top: 100, left: 10, right: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(
//                             left: 10, right: 10, top: 10, bottom: 10),
//                         decoration: BoxDecoration(
//                           color: HexColor(global.primary_color),
//                           borderRadius: BorderRadius.all(Radius.circular(8)),
//                         ),
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/passport.png',
//                               height: 17,
//                               color: Colors.white,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 2),
//                             ),
//                             Text(
//                               "SOP",
//                               style: GoogleFonts.montserrat(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(
//                             left: 10, right: 10, top: 10, bottom: 10),
//                         decoration: BoxDecoration(
//                           color: HexColor(global.primary_color),
//                           borderRadius: BorderRadius.all(Radius.circular(8)),
//                         ),
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/home.png',
//                               height: 17,
//                               color: Colors.white,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 2),
//                             ),
//                             Text(
//                               "Accomodation",
//                               style: GoogleFonts.montserrat(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(
//                             left: 10, right: 10, top: 10, bottom: 10),
//                         decoration: BoxDecoration(
//                           color: HexColor(global.primary_color),
//                           borderRadius: BorderRadius.all(Radius.circular(8)),
//                         ),
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/service.png',
//                               height: 17,
//                               color: Colors.white,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 2),
//                             ),
//                             Text(
//                               "Employment",
//                               style: GoogleFonts.montserrat(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20, right: 20, top: 30),
//                   child: Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: HexColor("DCDDF8"),
//                       borderRadius: BorderRadius.all(Radius.circular(5)),
//                     ),
//                     child: Text(
//                         "hello,asfygaifskjasfkjhafshakjsfhasfkhbasfkhabsf"),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 23, vertical: 100),
//                   child: Row(
//                     children: [
//                       ...List.generate(
//                           sop_services.length,
//                           (index) => GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selected_sop_service =
//                                         sop_services[index].toString();
//                                     //  print(selected_address_type);
//                                     sopServiceIndex = index;
//                                   });
//
//                                   //print(addressTypeIndex.value.toString());
//                                   print(sop_services[index].toString());
//                                   //  print(index);
//                                 },
//                                 child: Container(
//                                   height: 100,
//                                   width: 100,
//                                   // padding: const EdgeInsets.all(1),
//                                   margin: const EdgeInsets.only(
//                                       right: 10, left: 10),
//                                   decoration: sopServiceIndex == index
//                                       ? BoxDecoration(
//                                           shape: BoxShape.rectangle,
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10),
//                                           ),
//                                           border: Border.all(
//                                             width: 2,
//                                             color: HexColor(global.primary_color),
//                                           ),
//                                         )
//                                       : null,
//                                   child: Container(
//                                     child: Stack(
//                                       children: [
//                                         sopServiceIndex == index
//                                             ? Positioned(
//                                                 top: -1,
//                                                 left: 76,
//                                                 child: Icon(
//                                                   Icons.check_circle,
//                                                   color: HexColor('363CC0'),
//                                                   size: 20,
//                                                 ),
//                                               )
//                                             : Container(),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Image.network(
//                                               sop_services[index]['image_path'],
//                                               height: 30,
//                                               color: HexColor(global.primary_color),
//                                             ),
//                                             Center(
//                                               child: Text(
//                                                 sop_services[index]
//                                                         ['sop_service_name']
//                                                     .toString(),
//                                                 style: GoogleFonts.montserrat(
//                                                   color: HexColor(global.primary_color),
//                                                 ),
//                                                 textAlign: TextAlign.center,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     height: 100,
//                                     width: 100,
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(9)),
//                                       shape: BoxShape.rectangle,
//                                       color: HexColor("DCDDF8"),
//                                     ),
//                                   ),
//                                 ),
//                               ))
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 300,
//                   child: GridView.builder(
//                       shrinkWrap: true,
//                       physics: BouncingScrollPhysics(),
//                       //shrinkWrap : true,
//                       //itemCount: 2,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         childAspectRatio: 1.8,
//                         crossAxisCount: 1,
//                       ),
//                       scrollDirection: Axis.horizontal,
//                       itemCount: sop_services == null ? 0 : sop_services.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Container(
//                           color: Colors.red,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("wee"),
//                             ],
//                           ),
//                         );
//                       }),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),*/
//
//       /*Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Welcome, "),
//                 Text(global.fullname),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () async {
//                     SharedPreferences pref =
//                         await SharedPreferences.getInstance();
//                     pref.remove('isLoggedIn');
//                     pref.remove("user_id");
//                     pref.remove("full_name");
//                     pref.remove("contact");
//                     pref.remove("email");
//                     //_storeLoggedInStatus(true);
//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (context) => LoginPage()),
//                         (route) => false);
//                   },
//                   child: Container(
//                     width: 120,
//                     decoration: BoxDecoration(
//                       color: HexColor(global.primary_color),
//
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.all(Radius.circular(8)),
//                       // color: HexColor(global.secondary_color),
//                     ),
//                     margin: EdgeInsets.only(left: 30, right: 30, top: 20),
//                     height: 50,
//                     child: Center(
//                       child: Text(
//                         "Logout",
//                         style: GoogleFonts.montserrat(
//                             fontSize: 15,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),*/
//     );
//   }
// }
