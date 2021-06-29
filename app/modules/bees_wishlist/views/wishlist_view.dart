import 'package:bees_pharmacy/app/modules/bees_wishlist/controllers/wishlist_controller.dart';
import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/utils/wishlist_service_api.dart';
import 'package:bees_pharmacy/widgets/Container_widget.dart';
import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

class WishListView extends GetView<WishListController> {
  final WishListServiceApi wishListServiceApi = locator<WishListServiceApi>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => wishListServiceApi.state == ViewState.Busy
            ? _buildLoadingWidget()
            : _buildSuccessWidget()));
  }

  Widget _buildLoadingWidget() {
    return SpinKitCircle(color: Colors.blue[400]);
  }

  Widget _buildSuccessWidget() {
    return Obx(() => wishListServiceApi.wishListResponse.length < 1
        ? Center(
            child: Text(
              'No items in the wishlist!',
              style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  Obx(
                    () => Wrap(
                      spacing: 4,
                      children: List.generate(
                        wishListServiceApi.wishListResponse.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: InkWell(
                              onTap: () => Get.toNamed(Routes.DETAIL_PAGE,
                                  arguments: wishListServiceApi
                                      .wishListResponse[index]),
                              child: wishItemContainer(
                                wishListServiceApi.wishListResponse[index].name,
                                wishListServiceApi
                                    .wishListResponse[index].variant[0].price,
                                wishListServiceApi.wishListResponse[index]
                                            .photos.length ==
                                        0
                                    ? null
                                    : wishListServiceApi.wishListResponse[index]
                                        .photos[0].photo,
                                100,
                                156,
                                null,
                                Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                wishListServiceApi.wishListResponse[index].id,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
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
          padding: EdgeInsets.all(6),
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
                height: 100,
                child: imageName == null || imageName == ""
                    ? Image.asset(
                        "assets/loading.gif",
                        height: 72,
                        width: 72,
                        fit: BoxFit.contain,
                      )
                    : Image.network(
                        imageName,
                      ),
              ),
              gap(6, 0),
              Divider(thickness: 0.2, color: Colors.black.withOpacity(0.4)),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(fontWeight: FontWeight.w700),
                        maxLines: 1,
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
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4)),
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
                    onPressed: wishListController.state == ViewState.Busy
                        ? () {}
                        : () {
                            wishListController.deleteWishListItem(
                                id, "all-delete");
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
}
