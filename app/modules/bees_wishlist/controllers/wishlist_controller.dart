import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/utils/wishlist_service_api.dart';


class WishListController extends BaseController {
  WishListServiceApi wishListService = locator<WishListServiceApi>();
  int productId;

  @override
  void onInit() {
    super.onInit();
  }

  deleteWishListItem(int id, String category) async {
    setState(ViewState.Busy);
     await wishListService.deleteWishListItem(id, category);
    setState(ViewState.Retrieved);
  }
}
