import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginRegisterView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: Get.height,
          width: Get.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You are not logged in! \nLogin or Sign up to add items to your wish list!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                ),
              ),
              gap(24, 0),
              MaterialButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.1, vertical: 12),
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  color: Colors.blue[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN_PAGE, arguments: {"from": "a"});
                  })
            ],
          ),
        ),
      ),
    );
  }
}
