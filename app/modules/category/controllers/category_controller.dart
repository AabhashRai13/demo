import 'package:bees_pharmacy/api/api_auth_provider.dart';
import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/model/categories_model.dart';
import 'package:get/get.dart';

class CategoryController extends BaseController {
  ApiAuthProvider apiAuthProvider = ApiAuthProvider();

  Categories categories;
  final count = 0.obs;
  var categoriesAvailable = false.obs;
  List categoriesResponse = [].obs;

  void fetchCategories() async {
    setState(ViewState.Busy);
    categories = await apiAuthProvider.getAllCategories();
    categoriesResponse.assignAll(categories.results);
    categoriesAvailable.value = categories != null;
    print("Category name ${categoriesResponse[0].title}");
    setState(ViewState.Retrieved);
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
