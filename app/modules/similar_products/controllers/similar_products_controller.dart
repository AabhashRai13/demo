import 'package:bees_pharmacy/api/product_api.dart';
import 'package:bees_pharmacy/app/modules/detail_page/controllers/detail_page_controller.dart';
import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/model/product_model.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:get/get.dart';

class SimilarProductsController extends BaseController {
  final DetailPageController detailPageController =
      Get.put(DetailPageController());
  ProductApiProvider productApiProvider = ProductApiProvider();

  Products similarProducts;
  final count = 0.obs;
  var productAvailable = false.obs;
  List productResponse = [].obs;
  int id = Get.arguments.id;
  bool tokenNeeded = false;
  @override
  void onInit() {
    super.onInit();
    fetSimilarProducts(id);
    // print('category id $categoryId');
    checkIfOnline();
  }

  void checkIfOnline() {
    if (locator<SharedPreferencesManager>().isKeyExists('isLogin') == true) {
      tokenNeeded = true;
    } else {
      tokenNeeded = false;
    }
  }

  void fetSimilarProducts(int id) async {
    similarProducts =
        await productApiProvider.getSimilarProducts(id, tokenNeeded);
    productResponse.assignAll(similarProducts.results);
    productAvailable.value = similarProducts != null;
    print('similar products ${productResponse.length}');
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
