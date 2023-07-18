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

class UploadDocumentPage extends StatefulWidget {
  final String? application_id;
  const UploadDocumentPage({
    Key? key,
    this.application_id,
  }) : super(key: key);

  @override
  State<UploadDocumentPage> createState() => _UploadDocumentPageState();
}

class _UploadDocumentPageState extends State<UploadDocumentPage> {
  void initState() {
    super.initState();
    ///////////-EMPLOYMENT-/////////////////////
    if (global.employment_certificate_path == null) {
      employmentCertificate = null;
    } else {
      employmentCertificate = global.employment_certificate_path;
    }
    ///////////-PASSPORT-/////////////////////
    if (global.passport_copy_path == null) {
      passportCopy = null;
    } else {
      passportCopy = global.passport_copy_path;
    }
    ///////////-COURSE-/////////////////////
    if (global.course_certificate_path == null) {
      courseCertificate = null;
    } else {
      courseCertificate = global.course_certificate_path;
    }
    ///////////-TRAINING-/////////////////////
    if (global.training_course_path == null) {
      trainingCertificate = null;
    } else {
      trainingCertificate = global.training_course_path;
    }
    ///////////-MARRIAGE-/////////////////////
    if (global.marriage_certificate_path == null) {
      marriageCertificate = null;
    } else {
      marriageCertificate = global.marriage_certificate_path;
    }
    ///////////-IELTS-/////////////////////
    if (global.ielts_certificate_path == null) {
      ieltsCertificate = null;
    } else {
      ieltsCertificate = global.ielts_certificate_path;
    }
    ///////////-OFFER LETTER-/////////////////////
    if (global.offer_letter_path == null) {
      offerLetter = null;
    } else {
      offerLetter = global.offer_letter_path;
    }
    ///////////-LOAN LETTER-/////////////////////
    if (global.loan_letter_path == null) {
      loanLetter = null;
    } else {
      loanLetter = global.loan_letter_path;
    }
    ///////////-TUITION FEE RECEIPT-/////////////////////
    if (global.tuition_fee_receiept_path == null) {
      tuitionFeeReceipt = null;
    } else {
      tuitionFeeReceipt = global.tuition_fee_receiept_path;
    }
    ///////////-FUND RELATED DOC -/////////////////////
    if (global.fund_related_doc_path == null) {
      fundRelatedDoc = null;
    } else {
      fundRelatedDoc = global.fund_related_doc_path;
    }
    ///////////-FUND RELATED DOC -/////////////////////
    if (global.extra_curriculum_path == null) {
      extraCurriculum = null;
    } else {
      extraCurriculum = global.extra_curriculum_path;
    }
    ///////////-ANY REMARK -/////////////////////
    if (global.any_remark_path == null) {
      anyRemark = null;
    } else {
      anyRemark = global.any_remark_path;
    }
  }

  var passport_copy_status = "";
  var employment_certificate_status = "";
  var course_certificate_status = "";
  var training_certificate_status = "";
  var marriage_certificate_status = "";
  var ielts_certificate_status = "";
  var offer_letter_status = "";
  var loan_letter_status = "";
  var tuition_fee_receipt_status = "";
  var fund_related_doc_status = "";
  var extra_curriculum_status = "";
  var any_remark_status = "";

  Future<String> getDocumentStatus() async {
    print("Homepage Data Api Runs");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");
    configLoading();
    EasyLoading.show(status: 'Loading...');
    // final auths = await Authorization();
    var res = await http
        .post(Uri.parse(global.api_base_url + "get_document_status"), headers: {
      "Accept": "application/json",
      "Authorization": 'Bearer ' + global.authToken,
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": user_id,
      "application_id": widget.application_id,
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
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        employment_certificate_status = resp['employment_certificate_status'];
        passport_copy_status = resp['passport_copy_status'];
        course_certificate_status = resp['course_certificate_status'];
        training_certificate_status = resp['training_certificate_status'];
        marriage_certificate_status = resp['marriage_certificate_status'];
        ielts_certificate_status = resp['ielts_certificate_status'];
        offer_letter_status = resp['offer_letter_status'];
        loan_letter_status = resp['loan_letter_status'];
        tuition_fee_receipt_status = resp['tuition_fee_receipt_status'];
        fund_related_doc_status = resp['fund_related_doc_status'];
        extra_curriculum_status = resp['extra_curriculum_status'];
        any_remark_status = resp['any_remark_status'];
      });
    }
    print(resp);
    return "Success";
  }

///////////////////passport upload////////////////
///////////////////passport upload////////////////
///////////////////passport upload////////////////
  File? passportCopy;
  Future<void> choosePassportCopy() async {
    passport_copy_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      passportCopy = File(result!.files.single.path!);
      global.passport_copy_path = passportCopy;
    });
  }

  Future uploadPassport() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files
        .add(await http.MultipartFile.fromPath('file', passportCopy!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "passport_copy";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        passport_copy_status = result['status'];
      });
    }
    print(result);
  }
///////////////////passport upload////////////////
///////////////////passport upload////////////////
///////////////////passport upload////////////////

///////////////////marriage upload////////////////
///////////////////marriage upload////////////////
///////////////////marriage upload////////////////
  File? marriageCertificate;
  Future<void> chooseMarriageCertificate() async {
    marriage_certificate_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      marriageCertificate = File(result!.files.single.path!);
      global.marriage_certificate_path = marriageCertificate;
    });
  }

  Future uploadMarriageCertificate() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files.add(
        await http.MultipartFile.fromPath('file', marriageCertificate!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "marriage_certificate";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        marriage_certificate_status = result['status'];
      });
    }
    print(result);
  }
///////////////////marriage upload////////////////
///////////////////marriage upload////////////////
///////////////////marriage upload////////////////

  ///////////////////offer letter upload////////////////
///////////////////offer letter upload////////////////
///////////////////offer letter upload////////////////
  File? offerLetter;
  Future<void> chooseOfferLetter() async {
    offer_letter_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      offerLetter = File(result!.files.single.path!);
      global.offer_letter_path = offerLetter;
    });
  }

  Future uploadOfferLetter() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files
        .add(await http.MultipartFile.fromPath('file', offerLetter!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "offer_letter";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        offer_letter_status = result['status'];
      });
    }
    print(result);
  }
///////////////////offer letter upload////////////////
///////////////////offer letter upload////////////////
///////////////////offer letter upload////////////////

  ///////////////////loan letter upload////////////////
///////////////////loan letter upload////////////////
///////////////////loan letter upload////////////////
  File? loanLetter;
  Future<void> chooseLoanLetter() async {
    loan_letter_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      loanLetter = File(result!.files.single.path!);
      global.loan_letter_path = loanLetter;
    });
  }

  Future uploadLoanLetter() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files
        .add(await http.MultipartFile.fromPath('file', loanLetter!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "loan_letter";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        loan_letter_status = result['status'];
      });
    }
    print(result);
  }
///////////////////loan letter upload////////////////
///////////////////loan letter upload////////////////
///////////////////loan letter upload////////////////

  ///////////////////tuition fee receipt upload////////////////
///////////////////tuition fee receipt upload////////////////
///////////////////tuition fee receipt upload////////////////
  File? tuitionFeeReceipt;
  Future<void> chooseTuitionFeeReceipt() async {
    tuition_fee_receipt_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      tuitionFeeReceipt = File(result!.files.single.path!);
      global.tuition_fee_receiept_path = tuitionFeeReceipt;
    });
  }

  Future uploadTuitionFeeReceipt() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files.add(
        await http.MultipartFile.fromPath('file', tuitionFeeReceipt!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "tuition_fee_receipt";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        tuition_fee_receipt_status = result['status'];
      });
    }
    print(result);
  }
///////////////////tuition fee receipt upload////////////////
///////////////////tuition fee receipt upload////////////////
///////////////////tuition fee receipt upload////////////////

  ///////////////////course certificate upload////////////////
///////////////////course certificate upload////////////////
///////////////////course certificate upload////////////////
  File? courseCertificate;
  Future<void> chooseCourseCertificate() async {
    course_certificate_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      courseCertificate = File(result!.files.single.path!);
      global.course_certificate_path = courseCertificate;
    });
  }

  Future uploadCourseCertificate() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files.add(
        await http.MultipartFile.fromPath('file', courseCertificate!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "course_certificate";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        course_certificate_status = result['status'];
      });
    }
    print(result);
  }
///////////////////course certificate upload////////////////
///////////////////course certificate upload////////////////
///////////////////course certificate upload////////////////

  ///////////////////employment certificate upload////////////////
///////////////////employment certificate upload////////////////
///////////////////employment certificate upload////////////////

  File? employmentCertificate;
  Future<void> chooseEmploymentCertificate() async {
    employment_certificate_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      employmentCertificate = File(result!.files.single.path!);
      global.employment_certificate_path = employmentCertificate;
    });
  }

  Future uploadEmploymentCertificate() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files.add(
        await http.MultipartFile.fromPath('file', employmentCertificate!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "employment_certificate";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        employment_certificate_status = result['status'];
      });
    }
    print(result);
  }
///////////////////employment certificate upload////////////////
///////////////////employment certificate upload////////////////
///////////////////employment certificate upload////////////////

  ///////////////////training certificate upload////////////////
///////////////////training certificate upload////////////////
///////////////////training certificate upload////////////////
  File? trainingCertificate;
  Future<void> chooseTrainingCertificate() async {
    training_certificate_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      trainingCertificate = File(result!.files.single.path!);
      global.training_course_path = trainingCertificate;
    });
  }

  Future uploadTrainingCertificate() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files.add(
        await http.MultipartFile.fromPath('file', trainingCertificate!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "training_certificate";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        training_certificate_status = result['status'];
      });
    }
    print(result);
  }
///////////////////training certificate upload////////////////
///////////////////training certificate upload////////////////
///////////////////training certificate upload////////////////

  ///////////////////ielts certificate upload////////////////
///////////////////ielts certificate upload////////////////
///////////////////ielts certificate upload////////////////
  File? ieltsCertificate;
  Future<void> chooseIeltsCertificate() async {
    ielts_certificate_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      ieltsCertificate = File(result!.files.single.path!);
      global.ielts_certificate_path = ieltsCertificate;
    });
  }

  Future uploadIeltsCertificate() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files
        .add(await http.MultipartFile.fromPath('file', ieltsCertificate!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "ielts_certificate";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        ielts_certificate_status = result['status'];
      });
    }
    print(result);
  }
///////////////////ielts certificate upload////////////////
///////////////////ielts certificate upload////////////////
///////////////////ielts certificate upload////////////////

  ///////////////////fund related doce upload////////////////
///////////////////fund related doc upload////////////////
///////////////////fund related doc upload////////////////
  File? fundRelatedDoc;
  Future<void> chooseFundRelatedRoc() async {
    fund_related_doc_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      fundRelatedDoc = File(result!.files.single.path!);
      global.fund_related_doc_path = fundRelatedDoc;
    });
  }

  Future uploadFundRelatedDoc() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files
        .add(await http.MultipartFile.fromPath('file', fundRelatedDoc!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "fund_related_doc";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        fund_related_doc_status = result['status'];
      });
    }
    print(result);
  }
///////////////////fund related doc upload////////////////
///////////////////fund related doc upload////////////////
///////////////////fund related doc upload////////////////

  ///////////////////extra curriculum upload////////////////
///////////////////extra curriculum upload////////////////
///////////////////extra curriculum upload////////////////
  File? extraCurriculum;
  Future<void> chooseExtraCurriculum() async {
    extra_curriculum_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      extraCurriculum = File(result!.files.single.path!);
      global.extra_curriculum_path = extraCurriculum;
    });
  }

  Future uploadExtraCurriculum() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files
        .add(await http.MultipartFile.fromPath('file', extraCurriculum!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "extra_curriculum";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        extra_curriculum_status = result['status'];
      });
    }
    print(result);
  }
///////////////////extra curriculum upload////////////////
///////////////////extra curriculum upload////////////////
///////////////////extra curriculum upload////////////////

  ///////////////////any remark upload////////////////
///////////////////any remark upload////////////////
///////////////////any remark upload////////////////
  File? anyRemark;
  Future<void> chooseAnyRemark() async {
    any_remark_status = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    setState(() {
      anyRemark = File(result!.files.single.path!);
      global.any_remark_path = anyRemark;
    });
  }

  Future uploadAnyRemark() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(global.api_base_url + "sop_application_update_document"));
    request.files
        .add(await http.MultipartFile.fromPath('file', anyRemark!.path));
    request.fields['secrete'] = "dacb465d593bd139a6c28bb7289fa798";
    request.fields['column_name'] = "any_remark";
    request.fields['application_id'] = widget.application_id!;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (result['status'] == '0') {
      EasyLoading.dismiss();
      final snackBar = SnackBar(
        content: Text(result['message']),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
    } else {
      EasyLoading.dismiss();
      setState(() {
        any_remark_status = result['status'];
      });
    }
    print(result);
  }
///////////////////any remark upload////////////////
///////////////////any remark upload////////////////
//////////////////any remark upload////////////////

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
                onTap: () async {
                  Navigator.pop(context, false);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
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
              GestureDetector(
                onTap: () {
                  if (employmentCertificate == null ||
                      employment_certificate_status == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                          "Please Upload Employment/Gap Evidence/Internship/Training Certificate"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (passportCopy == null ||
                      passport_copy_status == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text("Please Upload Passport Copy"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (courseCertificate == null ||
                      course_certificate_status == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                          "Please Upload 10th/12th, Diploma. Bachelor, Master, Any Certificate"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (trainingCertificate == null ||
                      training_certificate_status == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text("Please Upload Any Training Certificate"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (marriageCertificate == null ||
                      marriage_certificate_status == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text("Please Upload Marriage Certificate"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (ieltsCertificate == null ||
                      ielts_certificate_status == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                          "Please Upload IELTS Or Other Language Test Certificate"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (offerLetter == null || offer_letter_status == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text("Please Upload Offer Letter"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (loanLetter == null || loan_letter_status == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text("Please Upload Loan Letter"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (tuitionFeeReceipt == null ||
                      tuitionFeeReceipt == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text("Please Upload Tuition Fee Receipt"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (fundRelatedDoc == null ||
                      fund_related_doc_status == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content:
                          Text("Please Upload GIC, FTS, Any Fund Related Doc"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (extraCurriculum == null ||
                      extra_curriculum_status == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text("Please Upload Extra Curriculum"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (anyRemark == null || any_remark_status == "") {
                    final snackBar = SnackBar(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text("Please Upload If Any Remark"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  /* Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaymentPage()));*/
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
                  "Upload Documents",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: HexColor(global.primary_color).withOpacity(.8)),
                ),
              ),
            ),

            //////////EMPLOYMENT CERTIFICATE BLOCK////////////////////
            //////////EMPLOYMENT CERTIFICATE BLOCK////////////////////
            //////////EMPLOYMENT CERTIFICATE BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "Employment/Gap Evidence/Internship/Training Certificate",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                chooseEmploymentCertificate();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: employmentCertificate == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose Employment Certificate",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(employmentCertificate!.path),
                                  ),
                                ],
                              ),
                            ),
                            employment_certificate_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadEmploymentCertificate();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////EMPLOYMENT CERTIFICATE BLOCK////////////////////
            //////////EMPLOYMENT CERTIFICATE BLOCK////////////////////
            //////////EMPLOYMENT CERTIFICATE BLOCK////////////////////
            //---------------------------------------------//
            //////////PASSPORT COPY BLOCK////////////////////
            //////////PASSPORT COPY BLOCK////////////////////
            //////////PASSPORT COPY BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "Passport Copy",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                choosePassportCopy();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: passportCopy == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose Passport Copy",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(passportCopy!.path),
                                  ),
                                ],
                              ),
                            ),
                            passport_copy_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadPassport();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////PASSPORT COPY BLOCK////////////////////
            //////////PASSPORT COPY BLOCK////////////////////
            //////////PASSPORT COPY BLOCK////////////////////
            //---------------------------------------------//
            //////////COURSE CERTIFICATE BLOCK////////////////////
            //////////COURSE CERTIFICATE BLOCK////////////////////
            //////////COURSE CERTIFICATE BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "10th/12th, Diploma. Bachelor, Master, Any Certificate",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                chooseCourseCertificate();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: courseCertificate == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose Course Certificate",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(courseCertificate!.path),
                                  ),
                                ],
                              ),
                            ),
                            course_certificate_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadCourseCertificate();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////COURSE CERTIFICATE BLOCK////////////////////
            //////////COURSE CERTIFICATE BLOCK////////////////////
            //////////COURSE CERTIFICATE BLOCK////////////////////
            //---------------------------------------------//
            //////////TRAINING CERTIFICATE BLOCK////////////////////
            //////////TRAINING CERTIFICATE BLOCK////////////////////
            //////////TRAINING CERTIFICATE BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "Any Training Certificate",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                chooseTrainingCertificate();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: trainingCertificate == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose Training Certificate",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(trainingCertificate!.path),
                                  ),
                                ],
                              ),
                            ),
                            training_certificate_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadTrainingCertificate();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////TRAINING CERTIFICATE BLOCK////////////////////
            //////////TRAINING CERTIFICATE BLOCK////////////////////
            //////////TRAINING CERTIFICATE BLOCK////////////////////
            //---------------------------------------------//
            //////////MARRIAGE CERTIFICATE BLOCK////////////////////
            //////////MARRIAGE CERTIFICATE BLOCK////////////////////
            //////////MARRIAGE CERTIFICATE BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "Marriage Certificate",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                chooseMarriageCertificate();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: marriageCertificate == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose Marriage Certificate",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(marriageCertificate!.path),
                                  ),
                                ],
                              ),
                            ),
                            marriage_certificate_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadMarriageCertificate();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////MARRIAGE CERTIFICATE BLOCK////////////////////
            //////////MARRIAGE CERTIFICATE BLOCK////////////////////
            //////////MARRIAGE CERTIFICATE BLOCK////////////////////
            //---------------------------------------------//
            //////////IELTS CERTIFICATE BLOCK////////////////////
            //////////IELTS CERTIFICATE BLOCK////////////////////
            //////////IELTS CERTIFICATE BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "IELTS Or Other Language Test Certificate",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                chooseIeltsCertificate();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: ieltsCertificate == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose IELTS Certificate",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(ieltsCertificate!.path),
                                  ),
                                ],
                              ),
                            ),
                            ielts_certificate_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadIeltsCertificate();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////IELTS CERTIFICATE BLOCK////////////////////
            //////////IELTS CERTIFICATE BLOCK////////////////////
            //////////IELTS CERTIFICATE BLOCK////////////////////
            //---------------------------------------------//
            //////////OFFER LETTER BLOCK////////////////////
            //////////OFFER LETTER BLOCK////////////////////
            //////////OFFER LETTER BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "Offer Letter",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                chooseOfferLetter();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: offerLetter == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose Offer Letter",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(offerLetter!.path),
                                  ),
                                ],
                              ),
                            ),
                            offer_letter_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadOfferLetter();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////OFFER LETTER BLOCK////////////////////
            //////////OFFER LETTER BLOCK////////////////////
            //////////OFFER LETTER BLOCK////////////////////
            //---------------------------------------------//
            //////////LOAN LETTER BLOCK////////////////////
            //////////LOAN LETTER BLOCK////////////////////
            //////////LOAN LETTER BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "Loan Letter",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                chooseLoanLetter();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: loanLetter == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose Loan Letter",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(loanLetter!.path),
                                  ),
                                ],
                              ),
                            ),
                            loan_letter_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadLoanLetter();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////LOAN LETTER BLOCK////////////////////
            //////////LOAN LETTER BLOCK////////////////////
            //////////LOAN LETTER BLOCK////////////////////
            //---------------------------------------------//
            //////////TUITION FEE RECEIPT BLOCK////////////////////
            //////////TUITION FEE RECEIPT BLOCK////////////////////
            //////////TUITION FEE RECEIPT BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "Tuition Fee Receipt",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                chooseTuitionFeeReceipt();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: tuitionFeeReceipt == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose Tuition Fee Receipt",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(tuitionFeeReceipt!.path),
                                  ),
                                ],
                              ),
                            ),
                            tuition_fee_receipt_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadTuitionFeeReceipt();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////TUITION FEE RECEIPT BLOCK////////////////////
            //////////TUITION FEE RECEIPT BLOCK////////////////////
            //////////TUITION FEE RECEIPT BLOCK////////////////////
            //---------------------------------------------//
            //////////FUND RELATED DOC BLOCK////////////////////
            //////////FUND RELATED DOC BLOCK////////////////////
            //////////FUND RELATED DOC BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "GIC, FTS, Any Fund Related Doc",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                chooseFundRelatedRoc();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: fundRelatedDoc == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose Fund Related Doc",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(fundRelatedDoc!.path),
                                  ),
                                ],
                              ),
                            ),
                            fund_related_doc_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadFundRelatedDoc();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////FUND RELATED DOC BLOCK////////////////////
            //////////FUND RELATED DOC BLOCK////////////////////
            //////////FUND RELATED DOC BLOCK////////////////////
            //---------------------------------------------//
            //////////EXTRA CURRICULUM BLOCK////////////////////
            //////////EXTRA CURRICULUM BLOCK////////////////////
            //////////EXTRA CURRICULUM BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "Extra Curriculum",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                chooseExtraCurriculum();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: extraCurriculum == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose Extra Curriculum",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(extraCurriculum!.path),
                                  ),
                                ],
                              ),
                            ),
                            extra_curriculum_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadExtraCurriculum();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////EXTRA CURRICULUM BLOCK////////////////////
            //////////EXTRA CURRICULUM BLOCK////////////////////
            //////////EXTRA CURRICULUM BLOCK////////////////////
            //---------------------------------------------//
            //////////ANY REMARK BLOCK////////////////////
            //////////ANY REMARK BLOCK////////////////////
            //////////ANY REMARK BLOCK////////////////////
            Container(
              margin: EdgeInsets.only(left: 25, right: 20, top: 20),
              child: Text(
                "If Any Remark",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: HexColor(global.primary_color).withOpacity(.8)),
              ),
            ),
            GestureDetector(
              onTap: () {
                chooseAnyRemark();
              },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                alignment: Alignment.center,
                child: anyRemark == null
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upload.png',
                              height: 30,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              "Choose Any Remark",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  Text(
                                    basename(anyRemark!.path),
                                  ),
                                ],
                              ),
                            ),
                            any_remark_status == "1"
                                ? GestureDetector(
                                    onTap: () {
                                      final snackBar = SnackBar(
                                        content: Text(
                                            'You Have Already Uploaded This File'),
                                      );
                                      ScaffoldMessenger.of(
                                              context as BuildContext)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/upload.png',
                                            height: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text("Uploaded"),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      uploadAnyRemark();
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 5,
                                          bottom: 55,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/upload.png',
                                                height: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                              Text("Upload File"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ),
            //////////ANY REMARK BLOCK////////////////////
            //////////ANY REMARK BLOCK////////////////////
            //////////ANY REMARK BLOCK////////////////////
            //---------------------------------------------//
            Padding(
              padding: EdgeInsets.only(bottom: 80),
            ),
          ],
        ),
      ),
    );
  }
}
