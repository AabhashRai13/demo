import 'package:bees_pharmacy/app/modules/wishlist_icon/views/wishlist_icon_view.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/model/product_model.dart';
import 'package:bees_pharmacy/utils/wishlist_service_api.dart';
import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

WishListServiceApi wishListServiceApi = locator<WishListServiceApi>();
Widget productWiseContainer(
    Result products,
    String productName,
    String productDesc,
    double productPrice,
    String imageName,
    double imageHeight,
    double width,
    double discountRate,
    Icon icon,
    int id,
    bool added,
    function()) {
  var isAdded = false.obs;
  isAdded.value = added;
  return Stack(
    children: [
      Container(
        height: 180,
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
          top: 5,
          left: 8,
          child: WishListIconView(
            product: products,
          )),
      // Positioned(
      //   top: 10,
      //   left: 12,
      //   child:
      //   locator<SharedPreferencesManager>().isKeyExists('isLogin') == true
      //       ? Obx(() => isAdded.value == false
      //       ? IconButton(
      //     splashRadius: 3,
      //     constraints: BoxConstraints(),
      //     padding: EdgeInsets.all(0),
      //     icon: Icon(
      //       Icons.favorite_border,
      //       size: 18,
      //       color: Colors.blue,
      //     ),
      //     onPressed: () async {
      //       if (locator<SharedPreferencesManager>()
      //           .isKeyExists('isLogin') ==
      //           true) {
      //         print(id);
      //         bool success =
      //         await wishListServiceApi.addToWishList(id, "all-add", productDesc);
      //         if (success) {
      //           // products.isAdded = true;
      //           isAdded.value = true;
      //         }
      //       } else {
      //         Fluttertoast.showToast(
      //             msg: "Please login to add product to wishlist",
      //             toastLength: Toast.LENGTH_SHORT,
      //             gravity: ToastGravity.TOP,
      //             backgroundColor: Colors.blue[300],
      //             textColor: Colors.white,
      //             fontSize: 16.0);
      //       }
      //     },
      //   )
      //       : IconButton(
      //     splashRadius: 3,
      //     constraints: BoxConstraints(),
      //     padding: EdgeInsets.all(0),
      //     icon: Icon(
      //       Icons.favorite,
      //       size: 18,
      //       color: Colors.blue,
      //     ),
      //     onPressed: () async {
      //       print("product id${id}");
      //       bool success =
      //       await wishListServiceApi.deleteWishListItem(id, "all-delete");
      //       if (success) {
      //         // products.isAdded = false;
      //         isAdded.value = false;
      //       }
      //     },
      //   ))
      //       : IconButton(
      //     splashRadius: 3,
      //     constraints: BoxConstraints(),
      //     padding: EdgeInsets.all(0),
      //     icon: Icon(
      //       Icons.favorite_border,
      //       size: 18,
      //       color: Colors.blue,
      //     ),
      //     onPressed: () {
      //       Fluttertoast.showToast(
      //           msg: "Please login to add product to wishlist",
      //           toastLength: Toast.LENGTH_SHORT,
      //           gravity: ToastGravity.TOP,
      //           backgroundColor: Colors.blue[300],
      //           textColor: Colors.white,
      //           fontSize: 16.0);
      //     },
      //   ),
      // ),
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
