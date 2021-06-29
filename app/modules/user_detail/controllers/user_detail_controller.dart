import 'package:bees_pharmacy/api/api_auth_provider.dart';
import 'package:bees_pharmacy/api/profile_api.dart';
import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/model/account_profile_model.dart';
import 'package:bees_pharmacy/model/order_list_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserDetailController extends BaseController {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ApiAuthProvider apiAuthProvider = ApiAuthProvider();
  List orderResponse = [].obs;
  var orderAvailable = false.obs;

  final accountProfile = AccountProfileAPI();
  AccountProfileDetail accountProfileDetail;

  OrderList order;
  var accountIndex = 0.obs;
  var orderIndex = 0.obs;

  final count = 0.obs;

  bool changed = false;

  void updatePassword(Map map) async {
    setState(ViewState.Busy);
    changed = await apiAuthProvider.updatePassword(map);
    if (changed == true) {
      Fluttertoast.showToast(
          msg: "Password Updated Successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green[300],
          textColor: Colors.white,
          fontSize: 16.0);
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      setState(ViewState.Retrieved);
    }
  }

  void mapPassword() {
    Map map = {
      "current_password": currentPasswordController.text.trim(),
      "new_password": newPasswordController.text.trim(),
      "confirm_password": confirmPasswordController.text.trim()
    };
    updatePassword(map);
  }

  String name;

  fetchAccountDetail() async {
    setState(ViewState.Busy);
    accountProfileDetail = await apiAuthProvider.getProfile();
    print('account $accountProfileDetail');

    order = await apiAuthProvider.getOrderList();
    orderResponse.assignAll(order.results);
    orderAvailable.value = order != null;
    print(order);
    print('response length is ${orderResponse.length}');
    setState(ViewState.Retrieved);
  }

  @override
  void onInit() {
    super.onInit();
    fetchAccountDetail();
    // fetchOrderList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
