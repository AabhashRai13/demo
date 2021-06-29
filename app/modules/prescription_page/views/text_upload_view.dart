import 'package:bees_pharmacy/app/modules/prescription_page/controllers/prescription_page_controller.dart';
import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

class TextUploadView extends GetView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PrescriptionPageController prescriptionPageController =
      Get.put(PrescriptionPageController());
  final _formKey = GlobalKey<FormState>();

  final DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          body: Stack(children: [
            SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          SizedBox(
                            height: 20,
                          ),
                          input(
                              Icon(
                                Icons.article_outlined,
                                color: Colors.blue,
                                size: 18,
                              ),
                              'Prescribed By',
                              prescriptionPageController
                                  .prescribedByTextViewController,
                              false,
                              TextInputType.text,
                              1),
                          gap(Get.height * 0.01, 0),
                          InkWell(
                            onTap: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2021, 3, 5, 0, 0),
                                  maxTime: DateTime(2030, 12, 30, 23, 59),
                                  onChanged: (date) {
                                print(date);
                              }, onConfirm: (date) {
                                prescriptionPageController
                                    .prescribedDateTextViewController
                                    .text = date.toIso8601String();
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    offset: Offset(0, 0),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field cannot be empty';
                                  } else
                                    return null;
                                },
                                enabled: false,
                                controller: prescriptionPageController
                                    .prescribedDateTextViewController,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  fillColor: Colors.white,
                                  hintText: 'Enter prescribed date',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.date_range_outlined,
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          gap(Get.height * 0.01, 0),
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  offset: Offset(0, 0),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                input1(
                                    null,
                                    'Your Prescription',
                                    prescriptionPageController
                                        .prescriptionController,
                                    false,
                                    TextInputType.text,
                                    null),
                              ],
                            ),
                          ),
                          gap(Get.height * 0.05, 0),
                          Obx(() => MaterialButton(
                              onPressed: prescriptionPageController.state ==
                                      ViewState.Busy
                                  ? () {}
                                  : () {
                                      if (locator<SharedPreferencesManager>()
                                              .isKeyExists('isLogin') ==
                                          false) {
                                        print(
                                            'isLoggedin: ${locator<SharedPreferencesManager>().isKeyExists('isLogin')}');

                                        showLoginDialog(context);
                                      } else {
                                        if (_formKey.currentState.validate()) {
                                          prescriptionPageController
                                              .mapPrescriptionPressed();
                                        } else
                                          return;
                                      }
                                    },
                              padding: EdgeInsets.symmetric(vertical: 15),
                              color: Colors.blue[400],
                              minWidth: Get.width,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Obx(
                                () => prescriptionPageController
                                            .textState.value ==
                                        true
                                    ? SpinKitCircle(
                                        color: Colors.blue,
                                      )
                                    : Text(
                                        'Upload',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                              )))
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: showInstructions,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                  ),
                  width: Get.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Instructions',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_up_outlined,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ])),
    );
  }

  void showInstructions() {
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
//
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                width: Get.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Instructions',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  instructions(
                      'Step 1: Click to upload image of prescription.'),
                  SizedBox(height: Get.height * 0.012),
                  instructions('Step 2: Request for the quotation.'),
                  SizedBox(
                    height: Get.height * 0.012,
                  ),
                  instructions(
                      'Step 3: You will receive a notification to confirm.'),
                  SizedBox(
                    height: Get.height * 0.012,
                  ),
                  instructions('Step 4: Confirm orders and billing.'),
                  SizedBox(
                    height: Get.height * 0.012,
                  ),
                ],
              ),
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
      );
    });
  }

  Widget instructions(String points) {
    return Text(
      points,
      style: TextStyle(fontSize: 14),
    );
  }
}

Widget input1(
  Icon icon,
  String hint,
  TextEditingController textEditingController,
  bool obsecure,
  TextInputType textInputType,
  int lines,
) {
  return Container(
    child: TextFormField(
      maxLines: lines,
      keyboardType: textInputType,
      obscureText: obsecure,
      validator: (value) {
        if (value.isEmpty) {
          return '$hint cannot be empty';
        } else
          return null;
      },
      controller: textEditingController,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        suffixIcon: icon,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: hint,
        contentPadding: EdgeInsets.all(20),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    ),
  );
}

Future<void> showLoginDialog(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Login to your account?'),
          actions: <Widget>[
            MaterialButton(
                child: Text('Yes'),
                onPressed: () {
                  Get.back();
                  Get.toNamed(Routes.LOGIN_PAGE,
                      arguments: {"from": "prescription_page"});
                }),
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'))
          ],
        );
      });
}
