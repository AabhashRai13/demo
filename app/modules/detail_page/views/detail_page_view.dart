import 'dart:ui';
import 'package:bees_pharmacy/app/modules/Cart/controllers/add_to_cart_controller.dart';
import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:bees_pharmacy/widgets/homeWidget/similarproduct_tile.dart';
import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  final DetailPageController detailPageController =
      Get.put(DetailPageController());
  final AddToCartController cartController = Get.put(AddToCartController());

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
          body: ListView(children: [
            Stack(
              children: [
                Container(
                  height: 228,
                  color: Colors.white,
                  child: detailPageController.photos == null
                      ? Center(
                          child: Image.asset(
                            "assets/loading.gif",
                            height: 72,
                            width: 72,
                            fit: BoxFit.fill,
                          ),
                        )
                      : CarouselSlider(
                          items: [
                            Center(
                              child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                    detailPageController.photos.length,
                                    (index) {
                                      return Container(
                                        margin: EdgeInsets.only(top: 40),
                                        width: Get.width,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 80.0),
                                          child: Center(
                                            child: Image.network(
                                                detailPageController
                                                    .photos[index].photo),
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                          ],
                          options: CarouselOptions(
                            autoPlay: true,
                            disableCenter: true,
                            aspectRatio: 2.2,
                          ),
                        ),
                ),
                Positioned(
                    top: 10,
                    left: Get.width * 0.85,
                    child: Container(
                      width: Get.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Get.toNamed(Routes.CART),
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                    top: 10,
                    child: Container(
                      width: Get.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 3,
                    spreadRadius: 3,
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.04,
                          horizontal: Get.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gap(8, 0),
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: productSpecifications(
                                    detailPageController.name,
                                    20,
                                    Colors.black,
                                    FontWeight.bold),
                              ),
                            ],
                          ),
                          gap(4, 0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              productSpecifications(
                                  detailPageController.brand == null
                                      ? "N/A"
                                      : detailPageController.brand,
                                  16,
                                  Colors.blue,
                                  FontWeight.normal),
                              Row(
                                children: [
                                  productSpecifications(
                                      ' Rs.${detailPageController.variant[0].price.toString()}',
                                      20,
                                      Colors.black,
                                      FontWeight.normal),
                                  gap(0, 8),
                                  detailPageController.variant[0].oldPrice ==
                                              0 ||
                                          detailPageController
                                                  .variant[0].oldPrice <=
                                              detailPageController
                                                  .variant[0].price
                                      ? SizedBox()
                                      : Text(
                                          detailPageController
                                              .variant[0].oldPrice
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.red,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                  gap(0, 8),
                                  detailPageController.discountPercentage == 0
                                      ? SizedBox()
                                      : productSpecifications(
                                          "${detailPageController.discountPercentage.toString()} % ",
                                          14,
                                          Colors.grey,
                                          FontWeight.normal)
                                ],
                              ),
                            ],
                          ),
                          gap(4, 0),
                          Obx(() => Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: detailPageButton(
                                              Colors.white,
                                              "-",
                                              Colors.blue[400],
                                              () => detailPageController
                                                  .decrement(),
                                              detailPageController
                                                          .count.value ==
                                                      1
                                                  ? false
                                                  : true),
                                        ),
                                        GetBuilder<DetailPageController>(
                                            builder: (controller) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 6),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      20.0),
                                            ),
                                            width: 60,
                                            child: Center(
                                              child: TextFormField(
                                                onChanged: (values) {
                                                  detailPageController
                                                          .count.value =
                                                      int.parse(values);
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                controller: detailPageController
                                                    .countController
                                                  ..text = detailPageController
                                                      .count
                                                      .toString()
                                                  ..selection = TextSelection
                                                      .fromPosition(TextPosition(
                                                          offset:
                                                              detailPageController
                                                                  .countController
                                                                  .text
                                                                  .length)),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          );
                                        }),
                                        Expanded(
                                          flex: 2,
                                          child: detailPageButton(
                                              Colors.white,
                                              "+",
                                              Colors.blue[400],
                                              () => detailPageController
                                                  .increment(),
                                              true),
                                        ),
                                        Expanded(
                                            flex: 6,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18)),
                                                color: Colors.blue[400],
                                                onPressed: () {
                                                  detailPageController
                                                              .variant.length <=
                                                          0
                                                      ? cartController.insert(
                                                          detailPageController
                                                              .name,
                                                          detailPageController
                                                              .description,
                                                          Get.arguments.photos
                                                                      .length ==
                                                                  0
                                                              ? 'assets/loading.gif'
                                                              : Get
                                                                  .arguments
                                                                  .photos[0]
                                                                  .photo,
                                                          2,
                                                          // detailPageController
                                                          //     .price,
                                                          detailPageController
                                                              .id,
                                                          null,
                                                          "",
                                                          detailPageController
                                                              .count.value)
                                                      : _showVariantList(
                                                          context);
                                                },
                                                child: Text(
                                                  'Add to cart',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          gap(6, 0),
                          Divider(
                            color: Colors.black.withOpacity(0.5),
                            thickness: 0.5,
                          ),
                          gap(10, 0),
                          productSpecifications('Product Description', 20,
                              Colors.black, FontWeight.bold),
                          gap(2, 0),
                          Html(data: detailPageController.description),
                          gap(8, 0),
                          // Row(
                          //   children: [
                          //     productSpecifications('Expration Date: ', 16,
                          //         Colors.black, FontWeight.w500),
                          //     productSpecifications(
                          //         detailPageController.expireDate == null
                          //             ? "N/A"
                          //             : detailPageController.expireDate
                          //                 .toIso8601String(),
                          //         16,
                          //         Colors.black,
                          //         FontWeight.normal)
                          //   ],
                          // ),
                          gap(12, 0),
                          Row(
                            children: [
                              productSpecifications('On Sale: ', 16,
                                  Colors.black, FontWeight.w500),
                              detailPageController.isOnSale == true
                                  ? productSpecifications(
                                      'Yes', 16, Colors.green, FontWeight.w500)
                                  : productSpecifications(
                                      'No', 16, Colors.red, FontWeight.w500),
                            ],
                          ),
                          gap(12, 0),
                          Divider(
                            color: Colors.black.withOpacity(0.5),
                            thickness: 0.5,
                          ),
                          gap(12, 0),
                          productSpecifications('Related Products', 20,
                              Colors.black, FontWeight.bold),
                          gap(12, 0),

                          similarProducts(),
                          gap(14, 0),
                        ],
                      )),
                  gap(12, 0),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _showVariantList(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Variant'),
          content: SingleChildScrollView(
            child: ListBody(
                children:
                    List.generate(detailPageController.variant.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  minWidth: Get.width,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    cartController.insert(
                        detailPageController.name,
                        detailPageController.description,
                        detailPageController.paraPhoto,
                        detailPageController.variant[index].price,
                        detailPageController.id,
                        detailPageController.variant[index].id,
                        detailPageController.variant[index].variations.type
                            .toString(),
                        detailPageController.count.value);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(detailPageController.variant[index].variations.type),
                      Text(
                          detailPageController.variant[index].price.toString()),
                    ],
                  ),
                ),
              );
            })),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget productSpecifications(
      String name, double textSize, Color textColor, FontWeight fontWeight) {
    return Text(
      name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: textSize, color: textColor, fontWeight: fontWeight),
    );
  }

  Widget productSpecificationsContainer(
      Widget specificationHeading, Widget specificationContents) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        specificationHeading,
        gap(8, 0),
        specificationContents,
        gap(8, 0)
      ]),
    );
  }

  Widget detailPageButton(Color buttonColor, String text, Color textColor,
      function(), bool isEnabled) {
    return MaterialButton(
      shape: CircleBorder(),
      minWidth: 30,
      color: buttonColor,
      onPressed: isEnabled == false ? null : () => function(),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 30),
      ),
    );
  }

  Widget similarProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 230,
            child: Obx(
              () => detailPageController.productAvailable.value
                  ? detailPageController.productResponse.length == 0
                      ? Center(
                          child: Text(
                            'No related products!',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              detailPageController.productResponse.length,
                              (index) {
                            return SimilarWidget(
                              products:
                                  detailPageController.productResponse[index],
                            );
                          }))
                  : Center(
                      child: Container(
                      height: 60,
                      width: 60,
                      child: SpinKitCircle(
                        color: Colors.blue,
                      ),
                    )),
            )),
      ],
    );
  }
}
