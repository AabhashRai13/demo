import 'package:bees_pharmacy/api/api_auth_provider.dart';
import 'package:bees_pharmacy/app/modules/user_detail/controllers/user_detail_controller.dart';
import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UpdateProfileController extends BaseController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController shippingAddressController =
      TextEditingController();
  final TextEditingController billingAddressController =
      TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  ApiAuthProvider apiAuthProvider = ApiAuthProvider();
  bool changed = false;
  bool autovalidate = false;
  final UserDetailController userDetailController =
      Get.put(UserDetailController());

  void updateProfile(Map map) async {
    setState(ViewState.Busy);
    changed = await apiAuthProvider.updateProfile(map);
    if (changed == true) {
      Fluttertoast.showToast(
          msg: "Profile Updated Successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue[400],
          textColor: Colors.white,
          fontSize: 16.0);
      firstNameController.clear();
      lastNameController.clear();
      shippingAddressController.clear();
      billingAddressController.clear();
      contactController.clear();
      cityController.clear();
      addressController.clear();

      setState(ViewState.Retrieved);
      userDetailController.fetchAccountDetail();
      Get.back();
    } else
      return;
  }

  void updateState() {
    autovalidate = true;
  }

  void mapProfile() {
    Map map = {
      "first_name": firstNameController.text.trim(),
      "last_name": lastNameController.text.trim(),
      "gender": genderRadioValue.value == 0 ? "Male" : "Female",
      "shipping_addr": shippingAddressController.text.trim(),
      "billing_addr": billingAddressController.text.trim(),
      "contact_no": contactController.text.trim(),
      "city": cityController.text.trim(),
      "address": addressController.text.trim(),
    };
    updateProfile(map);
  }

  var genderRadioValue = 0.obs;

  void handleGenderChange(int val) {
    genderRadioValue.value = val;
    update();
    switch (genderRadioValue.value) {
      case 0:
        break;
      case 1:
        break;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
