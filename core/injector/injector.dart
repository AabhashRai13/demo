import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:bees_pharmacy/utils/wishlist_service_api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  SharedPreferencesManager sharedPreferencesManager =
      await SharedPreferencesManager.getInstance();
  locator.registerSingleton<SharedPreferencesManager>(sharedPreferencesManager);
  locator.registerSingleton<WishListServiceApi>(WishListServiceApi());
}
