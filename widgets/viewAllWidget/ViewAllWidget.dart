import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/utils/wishlist_service_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

WishListServiceApi wishListServiceApi = locator<WishListServiceApi>();
Widget listGridView(context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Obx(
        () => Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: wishListServiceApi.wishListResponse.length,
            itemBuilder: (BuildContext context, int index) {
              if (index.isEven) {
                return Column(
                  children: [
                    wishItemContainer(
                      wishListServiceApi.wishListResponse[index].name,
                      wishListServiceApi.wishListResponse[index].price,
                      wishListServiceApi
                          .wishListResponse[index].photos[0].photo,
                      100,
                      Get.width,
                      null,
                      Icon(
                        Icons.delete,
                        size: 18,
                        color: Colors.white,
                      ),
                      wishListServiceApi.wishListResponse[index].id,
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
      Obx(
        () => Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: wishListServiceApi.wishListResponse.length,
            itemBuilder: (BuildContext context, int index) {
              if (index.isOdd) {
                return Column(
                  children: [
                    wishItemContainer(
                      wishListServiceApi.wishListResponse[index].name,
                      wishListServiceApi.wishListResponse[index].price,
                      wishListServiceApi
                          .wishListResponse[index].photos[0].photo,
                      100,
                      Get.width,
                      null,
                      Icon(
                        Icons.delete,
                        size: 18,
                        color: Colors.white,
                      ),
                      wishListServiceApi.wishListResponse[index].id,
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    ],
  );
}

Widget wishItemContainer(
  String productName,
  double productPrice,
  String imageName,
  double imageHeight,
  double width,
  double discountRate,
  Icon icon,
  int id,
) {
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.all(5),
        width: width,
        margin: EdgeInsets.all(4),
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
              height: 100,
              child: imageName == null || imageName == ""
                  ? Image.asset(
                      "assets/loading.gif",
                      height: 72,
                      width: 72,
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      imageName,
                    ),
            ),
            Divider(thickness: 0.2, color: Colors.black.withOpacity(0.4)),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(fontWeight: FontWeight.w700),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Rs ${productPrice.toString()}')
                  ]),
            ),
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
      Positioned(
        top: 12,
        right: 12,
        child: icon == null
            ? Icon(null)
            : Container(
                padding: EdgeInsets.all(2),
                decoration:
                    BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(),
                  icon: icon,
                  onPressed: () {
                    wishListServiceApi.deleteWishListItem(id, "");
                  },
                ),
              ),
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}

