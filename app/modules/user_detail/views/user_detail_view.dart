import 'dart:ui';
import 'package:bees_pharmacy/app/modules/login_page/controllers/login_page_controller.dart';
import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/model/product_model.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controllers/user_detail_controller.dart';

class UserDetailView extends GetView<UserDetailController> {
  final UserDetailController userDetailController =
      Get.put(UserDetailController());
  final _formKey = GlobalKey<FormState>();
   Products products;
  final LoginPageController loginPageController =
      Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: locator<SharedPreferencesManager>().isKeyExists('isLogin') == false
          ? Scaffold(
              appBar: AppBar(
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
              ),
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Please login to view user details!',
                      style: TextStyle(
                          color: Colors.blue[400],
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  gap(16, 0),
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
                        Get.offNamed(Routes.LOGIN_PAGE,
                            arguments: {"from": "a"});
                      })
                ],
              )))
          : GestureDetector(
              onTap: () {
                final FocusScopeNode currentScope = FocusScope.of(context);
                if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                  FocusManager.instance.primaryFocus.unfocus();
                }
              },
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: Container(
                    height: Get.height,
                    width: Get.width,
                    child: DefaultTabController(
                      length: 3,
                      child: ListView(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: Get.height * 0.23,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/path2.png'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Positioned(
                                  top: 20,
                                  left: 15,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () => Get.back(),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                      gap(0, Get.width * 0.05),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'User Detail',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // gap(Get.height * 0.02, 0),
                                          // Obx(
                                          //   () => userDetailController
                                          //               .accountProfileDetail
                                          //               .firstName ==
                                          //           null
                                          //       ? SizedBox()
                                          //       : Text(
                                          //           'Hi ! ${userDetailController.accountProfileDetail.firstName}',
                                          //           style: TextStyle(
                                          //               color: Colors.white,
                                          //               fontSize: 24,
                                          //               fontWeight:
                                          //                   FontWeight.bold),
                                          //         ),
                                          // )
                                        ],
                                      )
                                    ],
                                  ))
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(0),
                            height: Get.height * 0.77 - safePadding,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TabBar(
                                      isScrollable: true,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicatorColor: Colors.blue,
                                      labelColor: Colors.black,
                                      unselectedLabelColor:
                                          Colors.grey.withOpacity(0.6),
                                      tabs: [
                                        tabBarText('Account Detail'),
                                        tabBarText('Order History'),
                                        tabBarText("Address")
                                      ]),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: TabBarView(children: [
                                    Obx(() => userDetailController.state ==
                                            ViewState.Busy
                                        ? SpinKitCircle(color: Colors.blue)
                                        : accountDetail()),
                                    Obx(() => userDetailController.state ==
                                            ViewState.Busy
                                        ? SpinKitCircle(color: Colors.blue)
                                        : orderList()),
                                    Obx(() => userDetailController.state ==
                                            ViewState.Busy
                                        ? SpinKitCircle(color: Colors.blue)
                                        : addressDetail())
                                  ]),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
    );
  }

  Widget orderList() {
    return userDetailController.orderResponse.length == 0
        ? Center(
            child: Text('No orders yet!',
                style: TextStyle(
                    color: Colors.blue[400],
                    fontWeight: FontWeight.w500,
                    fontSize: 20)),
          )
        : Container(
            child: ListView(
              children: List.generate(
                userDetailController.orderResponse.length,
                (index) {
                  return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: Offset(0, 0),
                              blurRadius: 3,
                              spreadRadius: 1,
                            )
                          ]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                                children: List.generate(
                                    userDetailController.orderResponse[index]
                                        .products.length, (index2) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 14),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        offset: Offset(0, 0),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                      )
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Products:'),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.55,
                                          child: Text(
                                            userDetailController
                                                .orderResponse[index]
                                                .products[index2]
                                                .productName,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.blue[500],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text('Quantity:'),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          userDetailController
                                              .orderResponse[index]
                                              .products[index2]
                                              .quantity
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.blue[500],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text('Variant:'),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          userDetailController
                                              .orderResponse[index]
                                              .products[index2]
                                              .variant
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.blue[500],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            })),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Email:'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Contact Number:'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Payment Type:'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Shipping Address:'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Billing Address:'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Address:'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('City:'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userDetailController
                                              .order.results[index].email,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[500],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          userDetailController.order
                                              .results[index].contactNumber
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[500],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          userDetailController
                                              .order.results[index].paymentType,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[500],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          userDetailController.order
                                              .results[index].shippingAddress,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[500],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          userDetailController.order
                                              .results[index].billingAddress,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[500],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          userDetailController
                                              .order.results[index].address,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[500],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          userDetailController
                                              .order.results[index].city,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]));
                },
              ),
            ),
          );
  }

  // Widget orderList() {
  //   return Container(
  //     child: ListView(
  //       children: List.generate(
  //         userDetailController.orderResponse.length,
  //         (index) {
  //           return Container(
  //             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //             padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(14),
  //                 color: Colors.white,
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.grey.withOpacity(0.4),
  //                     offset: Offset(0, 0),
  //                     blurRadius: 3,
  //                     spreadRadius: 1,
  //                   )
  //                 ]),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text('Products:'),
  //                     SizedBox(
  //                       width: 8,
  //                     ),
  //                     Column(
  //                         children: List.generate(
  //                             userDetailController.orderResponse[index].products
  //                                 .length, (index2) {
  //                       return Container(
  //                         width: Get.width * 0.62,
  //                         child: Text(
  //                           userDetailController.orderResponse[index]
  //                               .products[index2].productName,
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(
  //                             color: Colors.blue[500],
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       );
  //                     })),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Text('Email:'),
  //                     SizedBox(
  //                       width: 8,
  //                     ),
  //                     Text(
  //                       userDetailController.order.results[index].email,
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.blue[500],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Text('Contact Number:'),
  //                     SizedBox(
  //                       width: 8,
  //                     ),
  //                     Text(
  //                       userDetailController.order.results[index].contactNumber
  //                           .toString(),
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.blue[500],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Text('Payment Type:'),
  //                     SizedBox(
  //                       width: 8,
  //                     ),
  //                     Text(
  //                       userDetailController.order.results[index].paymentType,
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.blue[500],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Text('Shipping Address:'),
  //                     SizedBox(
  //                       width: 8,
  //                     ),
  //                     Text(
  //                       userDetailController
  //                           .order.results[index].shippingAddress,
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.blue[500],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Text('Billing Address:'),
  //                     SizedBox(
  //                       width: 8,
  //                     ),
  //                     Text(
  //                       userDetailController
  //                           .order.results[index].billingAddress,
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.blue[500],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Text('Address:'),
  //                     SizedBox(
  //                       width: 8,
  //                     ),
  //                     Text(
  //                       userDetailController.order.results[index].address,
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.blue[500],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Text('City:'),
  //                     SizedBox(
  //                       width: 8,
  //                     ),
  //                     Text(
  //                       userDetailController.order.results[index].city,
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.blue[500],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget tabBarText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget accountDetail() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          margin: EdgeInsets.only(top: 20),
          height: Get.height * 0.70,
          width: Get.width * 0.90,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 3,
                )
              ]),
          child: Obx(() => userDetailController.accountIndex.value == 0
              ? userDetails()
              : updatePassword())),
    );
  }

  Widget userDetails() {
    return GetBuilder<UserDetailController>(
        builder: (controller) => controller.accountProfileDetail == null
            ? SpinKitCircle(
                color: Colors.blue,
              )
            : Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Get.width * 0.015),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.06,
                          vertical: Get.height * 0.04),
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gap(28, 0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'First Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                      controller.accountProfileDetail
                                                  .firstName ==
                                              ""
                                          ? 'N/A'
                                          : controller
                                              .accountProfileDetail.firstName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ))
                                ],
                              ),
                              gap(20, 0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Last Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    controller.accountProfileDetail.lastName ==
                                            ""
                                        ? 'N/A'
                                        : controller
                                            .accountProfileDetail.lastName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              gap(20, 0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    controller.accountProfileDetail.email == ""
                                        ? 'N/A'
                                        : controller.accountProfileDetail.email,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              gap(20, 0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Gender',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    controller.accountProfileDetail.gender ==
                                            null
                                        ? 'N/A'
                                        : controller
                                            .accountProfileDetail.gender,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              gap(20, 0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Address',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    controller.accountProfileDetail.address ==
                                                null ||
                                            controller.accountProfileDetail
                                                    .address ==
                                                ""
                                        ? 'N/A'
                                        : controller
                                            .accountProfileDetail.address,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              gap(20, 0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping Address',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    controller.accountProfileDetail
                                                    .shippingAddress ==
                                                " " ||
                                            controller.accountProfileDetail
                                                    .shippingAddress ==
                                                null
                                        ? 'N/A'
                                        : controller.accountProfileDetail
                                            .shippingAddress,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              gap(20, 0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Billing Address',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    controller.accountProfileDetail
                                                    .billingAddress ==
                                                " " ||
                                            controller.accountProfileDetail
                                                    .billingAddress ==
                                                null
                                        ? 'N/A'
                                        : controller.accountProfileDetail
                                            .billingAddress,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              gap(26, 0),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () =>
                                      controller.accountIndex.value = 1,
                                  child: Text(
                                    'Change Password?',
                                    style: TextStyle(
                                        color: Colors.blue[400], fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                          color: Colors.blue,
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Get.toNamed(Routes.UPDATE_PROFILE);
                          }))
                ],
              ));
  }

  Widget updatePassword() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.015),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.05, vertical: Get.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      userDetailController.accountIndex.value = 0;
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  gap(0, 10),
                  Text(
                    'Change Password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              gap(14, 0),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        decoration:
                            InputDecoration(hintText: 'Current Password'),
                        controller:
                            userDetailController.currentPasswordController,
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Field cannot be empty";
                          } else
                            return null;
                        }),
                    gap(14, 0),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'New Password',
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                      obscureText: true,
                      obscuringCharacter: '*',
                      controller: userDetailController.newPasswordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Field cannot be empty";
                        } else
                          return null;
                      },
                    ),
                    gap(14, 0),
                    TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Confirm New Password'),
                      controller:
                          userDetailController.confirmPasswordController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value !=
                            userDetailController.newPasswordController.text) {
                          return "Password does not match";
                        } else if (value.isEmpty) {
                          return "Field cannot be empty";
                        } else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(60)),
                      minWidth: Get.width,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          userDetailController.mapPassword();
                        } else
                          return;
                      },
                      color: Colors.blue[400],
                      child: Text(
                        'Update Password',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderHistory(String orderStatus, String orderId, String image,
      String productName, double totalPrice) {
    return Card(
      margin: EdgeInsets.only(
          left: Get.width * 0.07,
          right: Get.width * 0.07,
          top: Get.height * 0.05),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Order Id:'), Text(orderId)]),
                ),
                Expanded(
                    flex: 3,
                    child: Text(
                      'Rs. $totalPrice',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            gap(10, 0),
            Row(
                children: List.generate(1, (index) {
              return orderContainer(image, productName);
            })),
            gap(10, 0),
            orderStatus == 'Pending'
                ? Text(
                    'Status: $orderStatus',
                    style: TextStyle(color: Colors.red),
                  )
                : Text(
                    'Status: $orderStatus',
                    style: TextStyle(color: Colors.green),
                  ),
          ],
        ),
      ),
    );
  }

  Widget orderHistoryDetail(String orderId, String image, String productName,
      String variant, int quantity, double price) {
    return Padding(
      padding: EdgeInsets.only(
          top: Get.height * 0.05,
          left: Get.width * 0.07,
          right: Get.width * 0.07),
      child: ListView(physics: ClampingScrollPhysics(), children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => userDetailController.orderIndex.value = 0,
                child: Icon(Icons.arrow_back),
              ),
            ),
            Expanded(
                flex: 8,
                child: Text('Order Id: $orderId',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )))
          ],
        ),
        gap(10, 0),
        ListView(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(
                4,
                (index) => orderHistoryCard(
                    image, productName, variant, quantity, price))),
      ]),
    );
  }

  Widget orderHistoryCard(String image, String productName, String variant,
      int quantity, double price) {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height * 0.02),
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Image(
                image: AssetImage(image),
                height: 100,
                width: 75,
                fit: BoxFit.fill,
              ),
            ),
            gap(0, Get.width * 0.05),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(variant),
                  gap(Get.height * 0.01, 0),
                  Text('Quantity: ${quantity.toString()}')
                ],
              ),
            ),
            gap(0, Get.width * 0.05),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Rs.$price',
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
            ),
            gap(0, Get.width * 0.02)
          ],
        ),
      ),
    );
  }

  Widget addressDetail() {
    return userDetailController.accountProfileDetail == null
        ? SpinKitCircle(
            color: Colors.blue,
          )
        : Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height * 0.6,
              width: Get.width * 0.90,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 3,
                    )
                  ]),
              child: Container(
                // height: Get.height * 0.25,
                // color: Colors.red,
                margin: EdgeInsets.only(
                    top: Get.height * 0.055,
                    left: Get.width * 0.07,
                    right: Get.width * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Billing Address',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        gap(6, 0),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (userDetailController.accountProfileDetail
                                                .billingAddress ==
                                            null ||
                                        userDetailController
                                                .accountProfileDetail
                                                .billingAddress ==
                                            " ")
                                    ? 'N/A'
                                    : userDetailController
                                        .accountProfileDetail.billingAddress,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    gap(14, 0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping Address',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        gap(8, 0),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (userDetailController.accountProfileDetail
                                                .shippingAddress ==
                                            " " ||
                                        userDetailController
                                                .accountProfileDetail
                                                .shippingAddress ==
                                            null)
                                    ? 'N/A'
                                    : userDetailController
                                        .accountProfileDetail.shippingAddress,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget orderContainer(String imageName, String productName) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(right: 8),
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5))]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () => userDetailController.orderIndex.value = 1,
                child: Image.asset(
                  imageName,
                  height: 50,
                ),
              ),
            ),
            Expanded(flex: 3, child: Text(productName))
          ],
        ),
      ),
    );
  }
}
