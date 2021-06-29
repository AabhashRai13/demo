import 'package:bees_pharmacy/base%20model/base_model.dart';

abstract class WishListService extends BaseController {
  fetchWishList();

  deleteWishListItem(int id);

  addToWishList(int id, String category);
}
