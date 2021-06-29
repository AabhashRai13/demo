import 'package:bees_pharmacy/api/api_auth_provider.dart';
import 'package:bees_pharmacy/app/modules/home/views/home_view.dart';
import 'package:bees_pharmacy/app/modules/login_page/views/login_page_view.dart';
import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/model/registration_model.dart';
import 'package:bees_pharmacy/model/token/token.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPageController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController secondPasswordController =
      TextEditingController();
  final TextEditingController firstPasswordController = TextEditingController();
  TextEditingController loginNameController = TextEditingController();
  TextEditingController registerNameController = TextEditingController();
  var busy = "".obs;
  final count = 0.obs;
  Token token;
  RegistrationResponse registrationResponse;
  ApiAuthProvider apiAuthProvider = ApiAuthProvider();
  final SharedPreferencesManager sharedPreferencesManager =
      locator<SharedPreferencesManager>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void updateState() {
    autovalidate = true;
  }

  void loginUser(Map map) async {
    String from = Get.arguments["from"];
    setState(ViewState.Busy);
    token = await apiAuthProvider.loginUser(map);

    if (token == null) {
      Fluttertoast.showToast(
          msg: "Check your credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue[300],
          textColor: Colors.white,
          fontSize: 16.0);
      setState(ViewState.Retrieved);
    } else {
      await sharedPreferencesManager.putString(
          SharedPreferencesManager.keyAccessToken, token.accessToken);
      print("access token ${token.accessToken}");
      await sharedPreferencesManager.putString(
          SharedPreferencesManager.keyRefreshToken, token.refreshToken);
      print("refresh token ${token.refreshToken}");

      await sharedPreferencesManager.putBool(
          SharedPreferencesManager.keyIsLogin, true);

      if (from == "prescription_page") {
        Get.back();
        Get.back();
      } else {
        Get.offAll(() => HomeView());
      }
      setState(ViewState.Retrieved);
    }
  }

  void mapInputsLogin() {
    Map map = {
      "username": loginNameController.text.trim(),
      "password": loginPasswordController.text.trim()
    };
    loginUser(map);
  }

  void registerUser(Map map) async {
    setState(ViewState.Busy);

    registrationResponse = await apiAuthProvider.registerUser(map);
    if (registrationResponse == null) {
      Get.snackbar(
          "An error occurred", "Check your credentials",
          colorText: Colors.white, backgroundColor: Colors.blue[300]);
    } else {
      Get.off(() => LoginPageView());
      loginNameController.clear();
      emailController.clear();
    }
    setState(ViewState.Retrieved);
  }

  void mapInputsRegister() {
    Map map = {
      "username": registerNameController.text.trim(),
      "email": emailController.text.trim(),
      "password": firstPasswordController.text.trim(),
      "password2": secondPasswordController.text.trim()
    };
    registerUser(map);
  }

  @override
  void onClose() {
    super.onClose();
    loginNameController.clear();
    emailController.clear();
    firstPasswordController.clear();
    secondPasswordController.clear();
    registerNameController.clear();
    loginPasswordController.clear();
  }
}
