import 'dart:core';

import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/model/product_model.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';

import 'package:bees_pharmacy/utils/dio_logging_interceptors.dart';
import 'package:dio/dio.dart';

class ProductApiProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = 'https://bees.prixa.live/api/';

  ProductApiProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

 

  Future<Products> getAllProducts(bool isTokenNeeded) async {
    try {
      final response = await _dio.get(
        'products/',
        options:
            locator<SharedPreferencesManager>().isKeyExists('isLogin') != true
                ? Options()
                : Options(
                    headers: {
                      'requirestoken': isTokenNeeded,
                    },
                  ),
      );

      if (response.statusCode == 200) {
        print('Data recieved');
        return Products.fromJson(response.data);
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

  Future<Products> getSearchedProducts(searchText, bool isTokenNeeded) async {
    try {
      final response = await _dio.get(
        'products/?search=$searchText',
        options:
            locator<SharedPreferencesManager>().isKeyExists('isLogin') != true
                ? Options()
                : Options(
                    headers: {
                      'requirestoken': isTokenNeeded,
                    },
                  ),
      );

      if (response.statusCode == 200) {
        print('Data recieved');
        return Products.fromJson(response.data);
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

  Future<Products> getBabyProducts(bool isTokenNeeded) async {
    try {
      print('get baby products');
      final response = await _dio.get(
        'products/?search=Baby Care',
        options:
            locator<SharedPreferencesManager>().isKeyExists('isLogin') != true
                ? Options()
                : Options(
                    headers: {
                      'requirestoken': isTokenNeeded,
                    },
                  ),
      );

      if (response.statusCode == 200) {
        print('Data recieved');

        return Products.fromJson(response.data);
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

  Future<Products> getSimilarProducts( id, bool isTokenNeeded) async {
    try {
      print('get baby products');
      final response = await _dio.get(
        'products/$id/similar',
        options:
            locator<SharedPreferencesManager>().isKeyExists('isLogin') != true
                ? Options()
                : Options(
                    headers: {
                      'requirestoken': isTokenNeeded,
                    },
                  ),
      );

      if (response.statusCode == 200) {
        print('Data recieved');
        return Products.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode;
      }
    } catch (error) {
      print('this is API Error');

      print("error: $error");
    }
    return null;
  }

  Future<Products> getCategoryWiseProducts(
      String categoryName, bool isTokenNeeded) async {
    try {
      print('get CategoryWise products');
      final response = await _dio.get(
        'products/?search=$categoryName',
        options:
            locator<SharedPreferencesManager>().isKeyExists('isLogin') != true
                ? Options()
                : Options(
                    headers: {
                      'requirestoken': isTokenNeeded,
                    },
                  ),
      );

      if (response.statusCode == 200) {
        print('Data recieved');

        return Products.fromJson(response.data);
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

  Future<Products> getBrandWiseProducts(
      String brandName, bool isTokenNeeded) async {
    try {
      print('get CategoryWise products');
      final response = await _dio.get(
        'products/?search=$brandName',
        options:
            locator<SharedPreferencesManager>().isKeyExists('isLogin') != true
                ? Options()
                : Options(
                    headers: {
                      'requirestoken': isTokenNeeded,
                    },
                  ),
      );

      if (response.statusCode == 200) {
        print('Data recieved');

        return Products.fromJson(response.data);
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
}
