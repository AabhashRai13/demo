import 'package:bees_pharmacy/app/modules/prescription_page/controllers/prescription_page_controller.dart';
import 'package:bees_pharmacy/app/modules/prescription_page/views/text_upload_view.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:bees_pharmacy/widgets/image_upload_selection.dart';
import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

class ImageUploadView extends GetView {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final PrescriptionPageController prescriptionPageController =
      Get.put(PrescriptionPageController());
  final _formKey = GlobalKey<FormState>();
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
        body: Container(
          height: Get.height,
          child: Form(
            key: _formKey,
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Container(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        input(
                            Icon(
                              Icons.article_outlined,
                              color: Colors.blue,
                              size: 18,
                            ),
                            'Prescribed By',
                            prescriptionPageController.prescribedByController,
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
                                    .prescribedDateController
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
                                    .prescribedDateController,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  filled: true,
                                  suffixIcon: Icon(
                                    Icons.date_range_outlined,
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  fillColor: Colors.white,
                                  hintText: 'Enter prescribed date',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        Stack(
                          children: [
                            GetBuilder<PrescriptionPageController>(
                                builder: (controller) => Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 30),
                                      decoration: controller.image == null
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                  width: 1,
                                                  style: BorderStyle.solid,
                                                  color: Colors.grey))
                                          : BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                  image: FileImage(
                                                      controller.image),
                                                  fit: BoxFit.fill),
                                            ),
                                      height: Get.height * 0.25,
                                      width: Get.width * 0.9,
                                      child: prescriptionPageController.image !=
                                              null
                                          ? null
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.06,
                                                ),
                                                Icon(
                                                  Icons.cloud_upload,
                                                  color: Colors.blue,
                                                  size: 46,
                                                ),
                                                SizedBox(height: 4),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 6,
                                                      horizontal: 30),
                                                  child: Text(
                                                    'Upload prescription from your phone or open camera to scan for new prescription.',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                )
                                              ],
                                            ),
                                    )),
                            Positioned(
                              top: 5,
                              right: -5,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.blue[400],
                                  size: 30,
                                ),
                                onPressed: () {
                                  prescriptionPageController.deleteImage();
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 3,
                              right: 0,
                              left: 0,
                              child: Container(
                                // color: Colors.red,
                                width: 150,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      imageUploadSelection(
                                          Colors.white,
                                          Icons.camera_alt,
                                          Colors.blue,
                                          'Open Camera',
                                          Colors.grey,
                                          18,
                                          () => prescriptionPageController
                                              .pickFromCamera()),
                                      imageUploadSelection(
                                          Colors.white,
                                          Icons.image,
                                          Colors.blue,
                                          'Open Gallery',
                                          Colors.grey,
                                          18,
                                          () => prescriptionPageController
                                              .pickFromGallery()),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        gap(16, 0),
                        MaterialButton(
                            minWidth: Get.width,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
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
                                      if (prescriptionPageController.image !=
                                          null) {
                                        if (_formKey.currentState.validate()) {
                                          prescriptionPageController
                                              .mapPrescriptionPressed();
                                        } else
                                          return;
                                      } else
                                        Fluttertoast.showToast(
                                            msg: 'Image required',
                                            backgroundColor: Colors.blue,
                                            textColor: Colors.white,
                                            gravity: ToastGravity.TOP,
                                            toastLength: Toast.LENGTH_SHORT);
                                    }
                                  },
                            color: Colors.blue,
                            child: Obx(
                              () => prescriptionPageController.state ==
                                      ViewState.Busy
                                  ? SpinKitCircle(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Upload Image',
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ))
                      ],
                    ),
                  ),
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
            ]),
          ),
        ),
      ),
    );
  }

  void showInstructions() {
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
}

Widget instructions(String points) {
  return Text(
    points,
    style: TextStyle(fontSize: 14),
  );
}
