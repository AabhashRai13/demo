import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:get/get.dart';

import '../../../../api/product_api.dart';
import '../../../../base model/base_model.dart';
import '../../../../constants/enum.dart';
import '../../../../model/product_model.dart';

class CategoryWiseProductViewController extends BaseController {
  ProductApiProvider productApiProvider = ProductApiProvider();

  Products products;
  final count = 0.obs;
  var productAvailable = false.obs;
  List productResponse = [].obs;
  bool tokenNeeded = false;
  String categoryName = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryWiseProducts();
    checkIfOnline();
  }

  void checkIfOnline() {
    if (locator<SharedPreferencesManager>().isKeyExists('isLogin') == true) {
      tokenNeeded = true;
    } else {
      tokenNeeded = false;
    }
  }

  void fetchCategoryWiseProducts() async {
    setState(ViewState.Busy);
    print("category name $categoryName");
    products = await productApiProvider.getCategoryWiseProducts(
        categoryName, tokenNeeded);

    productResponse.assignAll(products.results);
    productAvailable.value = products != null;

    setState(ViewState.Retrieved);
    update();
  }

  updateWidget(){
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
