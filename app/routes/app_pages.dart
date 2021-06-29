import 'package:get/get.dart';

import 'package:bees_pharmacy/app/modules/BrandWiseProductView/bindings/brand_wise_product_view_binding.dart';
import 'package:bees_pharmacy/app/modules/BrandWiseProductView/views/brand_wise_product_view_view.dart';
import 'package:bees_pharmacy/app/modules/Cart/bindings/cart_binding.dart';
import 'package:bees_pharmacy/app/modules/Cart/views/cart_view.dart';
import 'package:bees_pharmacy/app/modules/CategoryWiseProductView/bindings/category_wise_product_view_binding.dart';
import 'package:bees_pharmacy/app/modules/CategoryWiseProductView/views/category_wise_product_view_view.dart';
import 'package:bees_pharmacy/app/modules/Checkout/bindings/checkout_binding.dart';
import 'package:bees_pharmacy/app/modules/Checkout/views/checkout_view.dart';
import 'package:bees_pharmacy/app/modules/Detail_page_2/bindings/detail_page_2_binding.dart';
import 'package:bees_pharmacy/app/modules/Detail_page_2/views/detail_page_2_view.dart';
import 'package:bees_pharmacy/app/modules/ViewAll/bindings/view_all_binding.dart';
import 'package:bees_pharmacy/app/modules/ViewAll/views/view_all_view.dart';
import 'package:bees_pharmacy/app/modules/bees_wishlist/bindings/wishlist_binding.dart';
import 'package:bees_pharmacy/app/modules/bees_wishlist/views/wishlist_view.dart';
import 'package:bees_pharmacy/app/modules/brands/bindings/brands_binding.dart';
import 'package:bees_pharmacy/app/modules/brands/views/brands_view.dart';
import 'package:bees_pharmacy/app/modules/brands_list/bindings/brands_list_binding.dart';
import 'package:bees_pharmacy/app/modules/brands_list/views/brands_list_view.dart';
import 'package:bees_pharmacy/app/modules/category/bindings/category_binding.dart';
import 'package:bees_pharmacy/app/modules/category/views/category_view.dart';
import 'package:bees_pharmacy/app/modules/detail_page/bindings/detail_page_binding.dart';
import 'package:bees_pharmacy/app/modules/detail_page/views/detail_page_view.dart';
import 'package:bees_pharmacy/app/modules/drawer/bindings/drawer_binding.dart';
import 'package:bees_pharmacy/app/modules/drawer/views/drawer_view.dart';
import 'package:bees_pharmacy/app/modules/home/bindings/home_binding.dart';
import 'package:bees_pharmacy/app/modules/home/views/home_view.dart';
import 'package:bees_pharmacy/app/modules/intro_screen/bindings/intro_screen_binding.dart';
import 'package:bees_pharmacy/app/modules/intro_screen/views/intro_screen_view.dart';
import 'package:bees_pharmacy/app/modules/khalti_payment/bindings/khalti_payment_binding.dart';
import 'package:bees_pharmacy/app/modules/khalti_payment/views/khalti_payment_view.dart';
import 'package:bees_pharmacy/app/modules/login_page/bindings/login_page_binding.dart';
import 'package:bees_pharmacy/app/modules/login_page/views/login_page_view.dart';
import 'package:bees_pharmacy/app/modules/prescription_page/bindings/prescription_page_binding.dart';
import 'package:bees_pharmacy/app/modules/prescription_page/views/prescription_page_view.dart';
import 'package:bees_pharmacy/app/modules/product_list/bindings/product_list_binding.dart';
import 'package:bees_pharmacy/app/modules/product_list/views/product_list_view.dart';
import 'package:bees_pharmacy/app/modules/similar_products/bindings/similar_products_binding.dart';
import 'package:bees_pharmacy/app/modules/similar_products/views/similar_products_view.dart';
import 'package:bees_pharmacy/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:bees_pharmacy/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:bees_pharmacy/app/modules/update_profile/bindings/update_profile_binding.dart';
import 'package:bees_pharmacy/app/modules/update_profile/views/update_profile_view.dart';
import 'package:bees_pharmacy/app/modules/user_detail/bindings/user_detail_binding.dart';
import 'package:bees_pharmacy/app/modules/user_detail/views/user_detail_view.dart';
import 'package:bees_pharmacy/app/modules/wishlist_icon/bindings/wishlist_icon_binding.dart';
import 'package:bees_pharmacy/app/modules/wishlist_icon/views/wishlist_icon_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_SCREEN,
      page: () => IntroScreenView(),
      binding: IntroScreenBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.DRAWER,
      page: () => DrawerView(),
      binding: DrawerBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.PRESCRIPTION_PAGE,
      page: () => PrescriptionPageView(),
      binding: PrescriptionPageBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LIST,
      page: () => ProductListView(),
      binding: ProductListBinding(),
    ),
    // GetPage(
    //   name: _Paths.BABY_PRODUCTS,
    //   page: () => BabyProductsView(),
    //   binding: BabyProductsBinding(),
    // ),
    GetPage(
      name: _Paths.VIEW_ALL,
      page: () => ViewAllView(),
      binding: ViewAllBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => WishListView(),
      binding: WishListBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PAGE,
      page: () => DetailPageView(),
      binding: DetailPageBinding(),
    ),
    GetPage(
      name: _Paths.USER_DETAIL,
      page: () => UserDetailView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.USER_DETAIL,
      page: () => UserDetailView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: _Paths.SIMILAR_PRODUCTS,
      page: () => SimilarProductsView(),
      binding: SimilarProductsBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_WISE_PRODUCT_VIEW,
      page: () => CategoryWiseProductViewView(),
      binding: CategoryWiseProductViewBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.BRANDS,
      page: () => BrandsView(),
      binding: BrandsBinding(),
    ),
    GetPage(
      name: _Paths.KHALTI_PAYMENT,
      page: () => KhaltiPaymentView(),
      binding: KhaltiPaymentBinding(),
    ),
    GetPage(
      name: _Paths.BRANDS_LIST,
      page: () => BrandsListView(),
      binding: BrandsListBinding(),
    ),
    GetPage(
      name: _Paths.BRAND_WISE_PRODUCT_VIEW,
      page: () => BrandWiseProductView(),
      binding: BrandWiseProductViewBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PAGE_2,
      page: () => DetailPage2View(),
      binding: DetailPage2Binding(),
    ),
    GetPage(
      name: _Paths.WISHLIST_ICON,
      page: () => WishListIconView(),
      binding: WishlistIconBinding(),
    ),
  ];
}
