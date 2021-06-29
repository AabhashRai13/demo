import 'package:bees_pharmacy/api/product_api.dart';
import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/model/product_model.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:get/get.dart';

class BrandWiseProductViewController extends BaseController {
  ProductApiProvider productApiProvider = ProductApiProvider();

  Products products;
  final count = 0.obs;
  var productAvailable = false.obs;
  List productResponse = [].obs;
  bool tokenNeeded = false;
  String brandName = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    fetchBrandWiseProducts();
    checkIfOnline();
  }

  void checkIfOnline() {
    if (locator<SharedPreferencesManager>().isKeyExists('isLogin') == true) {
      tokenNeeded = true;
    } else {
      tokenNeeded = false;
    }
  }

  void fetchBrandWiseProducts() async {
    setState(ViewState.Busy);
    print("category name $brandName");
    products =
        await productApiProvider.getBrandWiseProducts(brandName, tokenNeeded);

    productResponse.assignAll(products.results);
    productAvailable.value = products != null;

    setState(ViewState.Retrieved);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
