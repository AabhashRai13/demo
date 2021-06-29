import 'package:bees_pharmacy/api/api_auth_provider.dart';
import 'package:bees_pharmacy/api/profile_api.dart';
import 'package:bees_pharmacy/app/modules/Cart/controllers/cart_controller.dart';
import 'package:bees_pharmacy/base%20model/base_model.dart';
import 'package:bees_pharmacy/constants/enum.dart';
import 'package:bees_pharmacy/model/account_profile_model.dart';
import 'package:bees_pharmacy/utils/dataBase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_khalti/flutter_khalti.dart';

class CheckoutController extends BaseController {
  final accountProfile = AccountProfileAPI();
  AccountProfileDetail accountProfileDetail;

  //CartController cartController = CartController();
  ApiAuthProvider apiAuthProvider = ApiAuthProvider();
  List<String> paymentOptions = ['Cash on Delivery', 'Pay via Khalti'];
  var category = "".obs;
  var totalPrice = Get.arguments['total'];

  final TextEditingController promoCodeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController billingAddressController =
      TextEditingController();
  final TextEditingController shippngAddrerssController =
      TextEditingController();

  fetchAccountDetail() async {
    setState(ViewState.Busy);
    accountProfileDetail = await apiAuthProvider.getProfile();
    print('account $accountProfileDetail');
    setState(ViewState.Retrieved);
  }

  final count = 0.obs;
  var conditionStatusRadioValue = 0.obs;
  var remarksRadioValue = 0.obs;
  var total = 0.obs;
  var addressTitle = 'Select Payment Option'.obs;
  List products = Get.arguments["productsMapList"];
  CartController cartController = Get.arguments["controller"];
  ApiAuthProvider _apiAuthProvider = ApiAuthProvider();

  Map checkoutMap;
  bool isOrdered = false;

  void checkoutMapping() {
    if (addressTitle.value == "Pay via Khalti") {
      sendToKhalti();
    } else {
      checkoutMap = {
        "email": emailController.text.trim(),
        "contact_number": numberController.text.trim(),
        "payment_type": addressTitle.value,
        "city": cityController.text.trim(),
        "address": addressController.text.trim(),
        "billing_address": billingAddressController.text.trim(),
        "shipping_address": shippngAddrerssController.text.trim(),
        "products": products,
      };
      print(checkoutMap);
      checkOutOrder(checkoutMap);
    }
  }

  sendToKhalti() {
    ///Khalti calculates money in paisa so converting it into rupees

    FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
        publicKey: "test_public_key_1105de95fd514cdab9b83446c9c481c8",
        urlSchemeIOS: "KhaltiPayFlutterExample");

    KhaltiProduct product =
        KhaltiProduct(id: "test", name: "Ausadi", amount: 1000);

    _flutterKhalti.startPayment(
        product: product,
        onSuccess: (data) {
          print("success $data");
          checkoutMap = {
            "email": emailController.text.trim(),
            "contact_number": numberController.text.trim(),
            "payment_type": "Khalti",
            "city": cityController.text.trim(),
            "address": addressController.text.trim(),
            "billing_address": billingAddressController.text.trim(),
            "shipping_address": shippngAddrerssController.text.trim(),
            "products": products,
          };
          print(checkoutMap);
          checkOutOrder(checkoutMap);
        },
        onFaliure: (error) {
          print("Failure message $error");
        });
  }

  deleteAllProducts() async {
    await DataBaseHelper.instance.deleteAll();
    Future.delayed(const Duration(milliseconds: 1500), () {
      cartController.products.clear();
      update();
      print("products length ${cartController.products.length}");
    });
  }

  checkOutOrder(map) async {
    setState(ViewState.Busy);
    isOrdered = await _apiAuthProvider.checkoutProducts(map);
    if (isOrdered) {
      print("order bhayo hai");
      deleteAllProducts();
      //  cartController.getCart();
      setState(ViewState.Retrieved);

      Get.back();
      Fluttertoast.showToast(
          msg: 'Order placed successfully!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue[400],
          textColor: Colors.white);
    } else {
      // Get.back();
      setState(ViewState.Retrieved);
      Fluttertoast.showToast(
          msg: 'Order could not be placed!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue[400],
          textColor: Colors.white);
    }
  }

  void handleConditionStatusRadioValueChange(int val) {
    conditionStatusRadioValue.value = val;
    update();
    switch (conditionStatusRadioValue.value) {
      case 0:
        break;
      case 1:
        break;
    }
  }

  void handleRemarksRadioValueChange(int val) {
    remarksRadioValue.value = val;
    update();
    switch (remarksRadioValue.value) {
      case 0:
        break;
      case 1:
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAccountDetail();
    print('arguments: ${Get.arguments}');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    checkoutMap.clear();
  }

  void increment() => count.value++;
}
