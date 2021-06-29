import 'dart:ui';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  final LoginPageController controller = Get.put(LoginPageController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final LoginPageController loginPageController =
      Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            key: _scaffoldKey,
            backgroundColor: Theme.of(context).primaryColor,
            body: Stack(
              children: [
                Container(
                  height: Get.height * 0.4,
                  child: Center(
                    child: Image.asset(
                      'assets/logo_bees.png',
                      height: 120,
                      width: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: Get.height * 0.55,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            blurRadius: 6,
                            spreadRadius: 1)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30,
                                bottom: Get.height * 0.03,
                                top: Get.height * 0.01),
                            child: Text(
                              'WELCOME!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30, right: 30, bottom: Get.height * 0.08),
                            child: Text(
                              'We provide you the pharmacy service. You can call us in working time or visit our office 24 hours. "The pharmacy that is available all day every day."',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                height: 1.3,
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.1,
                                      vertical: 12),
                                  color: Colors.white,
                                  onPressed: () {
                                    loginSheet();
                                  },
                                  child: Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                ),
                                MaterialButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.1,
                                      vertical: 12),
                                  color: Colors.white,
                                  onPressed: () {
                                    registerSheet();
                                  },
                                  child: Text(
                                    "REGISTER",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                )
              ],
            )),
      ),
    );
  }

  //button widget

  void loginSheet() {
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return DecoratedBox(
        decoration: BoxDecoration(color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
          child: Container(
            child: Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.zero,
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          input(
                              Icon(
                                Icons.email,
                                color: Colors.blue,
                                size: 18,
                              ),
                              "Name",
                              controller.loginNameController,
                              false,
                              TextInputType.text,
                              1),
                          SizedBox(
                            height: 20,
                          ),
                          input(
                              Icon(
                                Icons.lock,
                                color: Colors.blue,
                                size: 18,
                              ),
                              "Password",
                              controller.loginPasswordController,
                              true,
                              TextInputType.text,
                              1),
                          SizedBox(
                            height: 60,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                              child: Obx(() => MaterialButton(
                                    highlightElevation: 2,
                                    elevation: 6,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    child: controller.state == ViewState.Busy
                                        ? SpinKitCircle(
                                            color: Colors.blue,
                                          )
                                        : Text(
                                            "LOGIN",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                letterSpacing: 1,
                                                fontSize: 14),
                                          ),
                                    onPressed: controller.state ==
                                            ViewState.Busy
                                        ? () {}
                                        : () {
                                            if (controller.formKey.currentState
                                                .validate()) {
                                              controller.mapInputsLogin();
                                            }
                                            loginPageController.updateState();
                                            // Get.to(() => HomeView());
                                          },
                                  )),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height / 1.45,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue[600],
          ),
        ),
      );
    });
  }

  void registerSheet() {
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return DecoratedBox(
        decoration: BoxDecoration(color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
          child: Container(
            child: Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'REGISTER',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        input(
                            Icon(
                              Icons.account_circle,
                              color: Colors.blue,
                              size: 18,
                            ),
                            "Display Name",
                            controller.registerNameController,
                            false,
                            TextInputType.text,
                            null),
                        SizedBox(
                          height: 10,
                        ),
                        inputEmail(
                            Icon(
                              Icons.email,
                              color: Colors.blue,
                              size: 18,
                            ),
                            "E-mail",
                            controller.emailController,
                            false,
                            TextInputType.text,
                            null),
                        SizedBox(
                          height: 10,
                        ),
                        input(
                            Icon(
                              Icons.lock,
                              color: Colors.blue,
                              size: 18,
                            ),
                            "Password",
                            controller.firstPasswordController,
                            true,
                            TextInputType.text,
                            1),
                        SizedBox(
                          height: 10,
                        ),
                        input(
                            Icon(
                              Icons.lock,
                              color: Colors.blue,
                              size: 18,
                            ),
                            "Re-type password",
                            controller.secondPasswordController,
                            true,
                            TextInputType.text,
                            1),
                        SizedBox(
                          height: 28,
                        ),
                        Container(
                          child: Obx(() => MaterialButton(
                                highlightElevation: 2,
                                elevation: 6,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                child: controller.state == ViewState.Busy
                                    ? SpinKitCircle(
                                        color: Colors.blue,
                                      )
                                    : Text(
                                        "REGISTER",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            letterSpacing: 1,
                                            fontSize: 14),
                                      ),
                                onPressed: () {
                                  if (controller.formKey.currentState
                                      .validate()) {
                                    controller.mapInputsRegister();
                                  }
                                },
                              )),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height / 1.35,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue[600],
          ),
        ),
      );
    });
  }
}
