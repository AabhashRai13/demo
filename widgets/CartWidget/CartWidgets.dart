import 'package:bees_pharmacy/app/modules/Cart/controllers/add_to_cart_controller.dart';
import 'package:bees_pharmacy/app/modules/Cart/controllers/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../widet_page.dart';

final AddToCartController addToCartController = Get.put(AddToCartController());
Widget cartContainer(
    String productName,
    double productPrice,
    String imageName,
    double imageHeight,
    double imageWidth,
    double width,
    double discountRate,
    Icon icon,
    int index,
    int id,
    int variantId,
    String variantType,
    int quantity,
    CartController cartController,
    TextEditingController textEditingController) {
  return FutureBuilder(builder: (context, snapshot) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  imageName != null
                      ? Container(
                          height: imageHeight,
                          width: imageWidth,
                          child: Image.network(imageName),
                        )
                      : Container(
                          height: imageHeight,
                          width: imageWidth,
                          child: Image.asset("assets/loading.gif"),
                        )
                ],
              ),
              gap(0, 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * 0.5,
                    child: Text(
                      productName,
                      style: TextStyle(fontWeight: FontWeight.w700),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: Get.width * 0.5,
                    child: Text(
                      "Variant: $variantType",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Rs.$productPrice',
                    style: TextStyle(fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Obx(
                    () => Row(
                      children: [
                        MaterialButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          elevation: 0,
                          minWidth: 30,
                          height: 6,
                          color: Colors.blue[400],
                          child: Text(
                            '-',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          onPressed: cartController.count[index] <= 1
                              ? () {}
                              : () {
                                  cartController.decrement(index);
                                },
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 24,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Center(
                              child: TextFormField(
                            onEditingComplete: () {
                              quantity = int.parse(textEditingController.text);
                              cartController.count[index] =
                                  int.parse(textEditingController.text);
                              cartController.totalPrice[index] =
                                  productPrice * cartController.count[index];
                              FocusScope.of(context).requestFocus(FocusNode());
                              cartController.updatePrice();
                            },
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            controller: textEditingController
                              ..text = cartController.count[index].toString()
                              ..selection = TextSelection.fromPosition(
                                  TextPosition(
                                      offset:
                                          textEditingController.text.length)),
                            style: TextStyle(color: Colors.black),
                          )),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        MaterialButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          elevation: 0,
                          minWidth: 30,
                          height: 6,
                          color: Colors.blue[400],
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          onPressed: () {
                            cartController.increment(index);
                          },
                        ),
                        SizedBox(
                          width: 14,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
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
                        print("index $index");
                        print("quantity $quantity");
                        cartController.deleteProducts(
                            cartController.products[index].productId,
                            index,
                            variantId);
                      }),
                ),
        ),
      ],
    );
  });
}
