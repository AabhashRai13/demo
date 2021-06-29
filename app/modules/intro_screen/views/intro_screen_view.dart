import 'package:bees_pharmacy/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../controllers/intro_screen_controller.dart';

class IntroScreenView extends GetView<IntroScreenController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        body: IntroductionScreen(
          showNextButton: false,
          showSkipButton: false,
          showDoneButton: false,
          globalFooter: Padding(
            padding: EdgeInsets.only(bottom: Get.height * 0.04),
            child: MaterialButton(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.2, vertical: 20),
              color: Colors.blue[400],
              onPressed: () {
                Get.off(() => HomeView());
              },
              child: Text(
                'GET STARTED',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          rawPages: [
            tourWidget("assets/Image3.png", 'Upload Prescription',
                'Select the specialist and make an appointment through our app.'),
            tourWidget("assets/Image5.png", 'Easy Access Medicine',
                'Select the specialist and make an appointment through our app.'),
            tourWidget("assets/Image4.png", 'Vaccine Available',
                'Select the specialist and make an appointment through our app.'),
          ],
        ),
      ),
    );
  }
}

Widget tourWidget(String image, String title, String content) {
  return Stack(
    children: [
      Container(
        height: Get.height * 0.4,
        child: Center(
          child: Image.asset(
            image,
            height: Get.height * 0.90,
            width: Get.width * 0.90,
            fit: BoxFit.contain,
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: Get.height * 0.55,
          width: Get.width * 0.98,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  blurRadius: 6,
                  spreadRadius: 1)
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: Get.height * 0.05),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.2,
                )
              ]),
        ),
      )
    ],
  );
}
