import 'dart:async';
import 'package:bees_pharmacy/app/modules/home/views/home_view.dart';
import 'package:bees_pharmacy/app/modules/intro_screen/views/intro_screen_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  final count = 0.obs;

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Get.off(() => HomeView());
    } else {
      prefs.setBool('seen', true);
      Get.off(() => IntroScreenView());
    }
  }

  @override
  void onInit() {
    super.onInit();

    Timer(new Duration(seconds: 2), () {
      checkFirstSeen();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
