import 'package:bees_pharmacy/app/modules/category/views/category_view.dart';
import 'package:bees_pharmacy/app/modules/home/views/home_view.dart';

import 'package:bees_pharmacy/app/modules/prescription_page/views/prescription_page_view.dart';
import 'package:bees_pharmacy/app/modules/user_detail/views/user_detail_view.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

import '../controllers/drawer_controller.dart';

class DrawerView extends GetView<DrawerHomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.7,
      height: Get.height,
      decoration: BoxDecoration(
          color: Colors.blue[500],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(60), bottomRight: Radius.circular(60))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      ClipRRect(
                        child: ClipOval(
                            child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.black.withOpacity(0.5),
                        )),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(children: [
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text("User Detail",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.to(() => UserDetailView());
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.category_outlined,
                    color: Colors.white,
                  ),
                  title: Text("Categories",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.to(() => CategoryView());
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.article_outlined,
                    color: Colors.white,
                  ),
                  title: Text("Prescription Upload",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.to(() => PrescriptionPageView());
                  },
                ),


                locator<SharedPreferencesManager>().isKeyExists('isLogin') ==
                        true
                    ? ListTile(
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                        title: Text("Log Out",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content:
                                      Text('Are you sure, you want to logout?'),
                                  actions: <Widget>[
                                    MaterialButton(
                                        child: Text('Yes'),
                                        onPressed: () {
                                          locator<SharedPreferencesManager>()
                                              .clearKey('isLogin');
                                          locator<SharedPreferencesManager>()
                                              .clearKey('username');
                                          locator<SharedPreferencesManager>()
                                              .clearKey('accessToken');
                                          locator<SharedPreferencesManager>()
                                              .clearKey('refreshToken');
                                          Get.offAll(() => HomeView());
                                          Future.delayed(
                                              Duration(seconds: 1),
                                              () => Fluttertoast.showToast(
                                                  gravity: ToastGravity.TOP,
                                                  msg:
                                                      'Logged out of the account!',
                                                  textColor: Colors.white,
                                                  backgroundColor:
                                                      Colors.blue[400]));
                                        }),
                                    MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text('No'))
                                  ],
                                );
                              });
                        },
                      )
                    : SizedBox()

              ]),
            ],
          ),
        ],
      ),
    );
  }
}
