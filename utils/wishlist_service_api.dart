import 'package:bees_pharmacy/api/api_auth_provider.dart';
import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WishListServiceApi extends BaseController {
  ApiAuthProvider apiAuthProvider = ApiAuthProvider();

  List wishListResponse = [].obs;
  bool added = false;
  bool deleted = false;

  @override
  void onInit() {
    super.onInit();
  }

  fetchWishList() async {
    var response = await apiAuthProvider.getWishList();
    if (response != null) {
      wishListResponse.assignAll(response.results);
    }

    return wishListResponse;
  }

  deleteWishListItem(int id, String category) async {
    deleted = await apiAuthProvider.deleteWishList(id);
    if (deleted) {
      wishListResponse.removeWhere((item) => item.id == id);

      Fluttertoast.showToast(
          msg: "Product removed from wishlist!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue[300],
          textColor: Colors.white,
          fontSize: 16.0);
      return deleted;
    }
  }

  addToWishList(int id, String category, products) async {
    setState(ViewState.Busy);
    added = await apiAuthProvider.addToWishlist(id);
    if (added) {
      wishListResponse.add(products);
      print("response ${wishListResponse[0].name}");
      Fluttertoast.showToast(
          msg: "Product added to wishlist!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue[300],
          textColor: Colors.white,
          fontSize: 16.0);
      setState(ViewState.Retrieved);
      return added;
    } else {
      Fluttertoast.showToast(
          msg: "Error occured! Product could not be added to wishlist!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue[300],
          textColor: Colors.white,
          fontSize: 16.0);
      setState(ViewState.Retrieved);
    }
  }
}
