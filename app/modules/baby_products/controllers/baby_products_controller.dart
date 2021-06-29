import 'package:bees_pharmacy/api/product_api.dart';
import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/model/product_model.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';

import 'package:get/get.dart';

class BabyProductsController extends BaseController {
  ProductApiProvider productApiProvider = ProductApiProvider();

  Products products;
  final count = 0.obs;
  var productAvailable = false.obs;
  List productResponse = [].obs;
  bool tokenNeeded = false;

  @override
  void onInit() {
    super.onInit();
    checkIfOnline();
    fetchBabyProducts();
  }

  void checkIfOnline() {
    if (locator<SharedPreferencesManager>().isKeyExists('isLogin') == true) {
      tokenNeeded = true;
    } else {
      tokenNeeded = false;
    }
  }

  void fetchBabyProducts() async {
    setState(ViewState.Busy);

    products = await productApiProvider.getBabyProducts(tokenNeeded);

    productResponse.assignAll(products.results);
    productAvailable.value = products != null;
    setState(ViewState.Retrieved);
  }


}

