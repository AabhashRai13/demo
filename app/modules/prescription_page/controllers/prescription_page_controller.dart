import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../../../../api/api_auth_provider.dart';
import '../../../../base model/base_model.dart';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart' as dio;

import '../../../../constants/enum.dart';

class PrescriptionPageController extends BaseController {
  File image;

  final TextEditingController prescribedByController = TextEditingController();
  final TextEditingController prescriptionController = TextEditingController();
  final TextEditingController prescribedDateController =
      TextEditingController();

  final TextEditingController dateTextViewController = TextEditingController();
  final TextEditingController prescribedByTextViewController =
      TextEditingController();
  final TextEditingController prescribedDateTextViewController =
      TextEditingController();
  bool prescriptionAdded = false;
  ApiAuthProvider apiAuthProvider = ApiAuthProvider();
  var textState = false.obs;

  var selectedDate = "YY/MM/DD HR:SEC".obs;
  var selectedDateTextView = "YY/MM/DD HR:SEC".obs;

  String convertedDateTime =
      "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')} ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}";

  Future<void> pickFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    } else {
      print('No image selected.');
    }
  }

  Future<void> pickFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    } else {
      print('No image selected.');
    }
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print(convertedDateTime);
  }

  //to get a target path to provide for compressed file location
  Future<String> targetPath() async {
    final directory = await getApplicationDocumentsDirectory();
    String targetPath = directory.path + "/" + basename(image.path);
    print("Target Path $targetPath");
    return targetPath;
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 60,
    );

    return result;
  }

  void mapPrescriptionPressed() async {
    if (image != null) {
      File compressedImage =
          await testCompressAndGetFile(image, await targetPath());
      var formData = dio.FormData.fromMap({
        "image": await dio.MultipartFile.fromFile(compressedImage.path),
        "prescribed_by": prescribedByTextViewController.text.trim(),
        "uploaded_date": convertedDateTime,
        "prescribed_date": prescribedDateTextViewController.text.trim(),
      });
      sendPrescription(formData);
    } else {
      var formData = dio.FormData.fromMap({
        "prescription": prescriptionController.text.trim(),
        "prescribed_by": prescribedByTextViewController.text.trim(),
        "uploaded_date": convertedDateTime,
        "prescribed_date": prescribedDateTextViewController.text.trim(),
      });
      sendPrescription(formData);
    }
  }

  Future sendPrescription(myProductCreateMap) async {
    setState(ViewState.Busy);
    prescriptionAdded =
        await apiAuthProvider.postPrescription(myProductCreateMap);
    setState(ViewState.Retrieved);
    if (prescriptionAdded) {
      textState.value = true;
      Get.back();
      Fluttertoast.showToast(
          msg: 'Prescription added successfully!',
          backgroundColor: Colors.blue[400],
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP);
    }
  }

  void deleteImage() {
    image = null;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
