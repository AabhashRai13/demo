import 'package:bees_pharmacy/app/modules/bees_wishlist/controllers/wishlist_controller.dart';

import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

final WishListController wishListController = Get.put(WishListController());
var isAdded = false.obs;

Widget productContainer(
    String productName,
    String productDesc,
    double productPrice,
    String imageName,
    double imageHeight,
    double width,
    double discountRate,
    Icon icon,
    int id,
    function()) {
  return Stack(
    children: [
      Container(
        height: 170,
        width: width,
        margin: EdgeInsets.only(bottom: 18, left: 4, right: 4),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: Offset(0, 0),
                spreadRadius: 1,
                blurRadius: 4,
              )
            ]),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 100,
              child: imageName == null
                  ? Image.asset(
                      "assets/loading.gif",
                      height: 72,
                      width: 72,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      imageName,
                    ),
            ),
            gap(6, 0),
            Divider(thickness: 0.2, color: Colors.black.withOpacity(0.4)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: 155,
                    child: Text(
                      productName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  productDesc == "" || productPrice == null
                      ? SizedBox(
                          width: 0,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 280,
                              child: Html(
                                data: productDesc,
                                shrinkWrap: true,
                              ),
                            ),
                            Text(
                              'Rs.$productPrice',
                              style: TextStyle(fontWeight: FontWeight.w700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                ],
              ),
            ]),
          ],
        ),
      ),
      Positioned(
        top: 12,
        left: 12,
        child: discountRate == null
            ? Text('')
            : Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(4)),
                child: Text(
                  '${discountRate.toString()}%',
                  style: TextStyle(color: Colors.white),
                )),
      ),
      
      SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget banContainer(double height, double width, String image) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(14),
      image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          offset: Offset(-2, 4),
          blurRadius: 4,
          spreadRadius: 1,
        )
      ],
    ),
  );
}
