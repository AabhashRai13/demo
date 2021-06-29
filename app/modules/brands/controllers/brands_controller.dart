import 'package:bees_pharmacy/api/api_auth_provider.dart';
import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/model/brand_model.dart';
import 'package:get/get.dart';

class BrandsController extends BaseController {
  ApiAuthProvider apiAuthProvider = ApiAuthProvider();

  Brands brands;
  var brandsAvailable = false.obs;
  List brandsResponse = [].obs;

  void fetchBrands() async {
    // setState(ViewState.Busy);
    brands = await apiAuthProvider.getAllBrands();
    brandsResponse.assignAll(brands.results);
    brandsAvailable.value = brands != null;
 
    setState(ViewState.Retrieved);
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchBrands();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
