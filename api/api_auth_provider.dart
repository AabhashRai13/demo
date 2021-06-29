import 'package:bees_pharmacy/model/account_profile_model.dart';
import 'package:bees_pharmacy/model/brand_model.dart';
import 'package:bees_pharmacy/model/categories_model.dart';
import 'package:bees_pharmacy/model/order_list_model.dart';
import 'package:bees_pharmacy/model/refresh/refresh_token_model.dart';
import 'package:bees_pharmacy/model/registration_model.dart';
import 'package:bees_pharmacy/model/token/token.dart';
import 'package:bees_pharmacy/model/wish_list_model.dart';
import 'package:bees_pharmacy/utils/dio_logging_interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiAuthProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = 'https://bees.prixa.live/api/';

  ApiAuthProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  void _printError(error, StackTrace stacktrace) {
    debugPrint('error: $error & stacktrace: $stacktrace');
  }

  Future<Token> loginUser(map) async {
    try {
      final response = await _dio.post(
        'auth/token/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: map,
      );

      if (response.statusCode == 200) {
        return Token.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return null;
    }
    return null;
  }

  Future<RefreshToken> refreshAuth(map) async {
    try {
      final response = await _dio.post(
        'auth/token/refresh/',
        data: map,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return RefreshToken.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return RefreshToken.withError('$error');
    }
  }

  Future<RegistrationResponse> registerUser(Map map) async {
    try {
      final response = await _dio.post(
        'register/',
        data: map,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      return RegistrationResponse.fromJson(response.data);
    } catch (error) {
      print("Registration error $error");
      return null;
    }
  }

  Future<WishListProducts> getWishList() async {
    try {
      print('getwishlist');
      final response = await _dio.get(
        'wishlist/',
        options: Options(
          headers: {
            'requirestoken': true,
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Data recieved');
        return WishListProducts.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode;
      }
    } catch (error) {
      print(' API Error');
      print(error);
    }
    return null;
  }

  Future<OrderList> getOrderList() async {
    try {
      print('get order list');
      final response = await _dio.get(
        'order-list/',
        options: Options(
          headers: {
            'requirestoken': true,
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Data recieved');
        return OrderList.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode;
      }
    } catch (error) {
      print(' API Error');
      print(error);
    }
    return null;
  }

  Future<Categories> getAllCategories() async {
    try {
      final response = await _dio.get(
        'categories/',
        options: Options(),
      );

      if (response.statusCode == 200) {
        print('Data recieved');
        return Categories.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode;
      }
    } catch (error) {
      print(' API Error');
      print(error);
      return null;
    }
  }

  Future<Brands> getAllBrands() async {
    try {
      final response = await _dio.get(
        'brand/',
        options: Options(),
      );

      if (response.statusCode == 200) {
        print('Data recieved');
        return Brands.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode;
      }
    } catch (error) {
      print(' API Error');
      print(error);
      return null;
    }
  }

  Future<AccountProfileDetail> getProfile() async {
    try {
      print('getAllUsers');
      final response = await _dio.get(
        'accounts/',
        options: Options(
          headers: {
            'requirestoken': true,
          },
        ),
      );
      print(response.data);
      return AccountProfileDetail.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return null;
    }
  }

  addToWishlist(int id) async {

    try {
      final response = await _dio.get('wishlist/$id',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'requirestoken': true,
          }));
      print("response status ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      print("Change Status error $error");
      return false;
    }
    return null;
  }

  deleteWishList(int id) async {
    try {
      print('add to cart list');
      final response = await _dio.get(
        'wishlist/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'requirestoken': true,
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      print('Wishlist API Error');
      print(error);
      return false;
    }
    return null;
  }

  updatePassword(map) async {
    try {
      final response = await _dio.post('reset-password/',
          data: map,
          options: Options(
            headers: {'requirestoken': true},
          ));
      print("response staus ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      print(error);
      return null;
    }
    return null;
  }

  updateProfile(map) async {
    try {
      final response = await _dio.put('accounts/',
          data: map,
          options: Options(
            headers: {'requirestoken': true},
          ));
      print("response staus ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
    } catch (error) {
      print(error);
      return null;
    }
    return null;
  }

  checkoutProducts(map) async {
    try {
      final response = await _dio.post('order/',
          data: map,
          options: Options(
            headers: {'requirestoken': true},
          ));
      print("response status ${response.statusCode}");
      if (response.statusCode == 201) {
        return true;
      }
    } catch (error) {
      print(error);
      return false;
    }
    return null;
  }

  postPrescription(prescription) async {
    try {
      final response = await _dio.post(
        'prescription/',
        data: prescription,
        options: Options(
          headers: {
            'requirestoken': true,
          },
        ),
      );
      print("status code ${response.statusCode}");
      print(" response ${response.data}");
      if (response.statusCode == 201) {
        return true;
      } else {
        print(response.data.toString());
      }
    } catch (error) {
      print("create product address error $error");
    }
  }
}
