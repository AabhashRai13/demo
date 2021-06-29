import 'package:bees_pharmacy/api/api_auth_provider.dart';
import 'package:bees_pharmacy/core/injector/injector.dart';
import 'package:bees_pharmacy/model/refresh/refresh_token_model.dart';
import 'package:bees_pharmacy/storage/sharedprefences/shared_preferences_manager.dart';
import 'package:dio/dio.dart';

class DioLoggingInterceptors extends InterceptorsWrapper {
  final Dio _dio;
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  DioLoggingInterceptors(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
    print(
        "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
    print("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    if (options.queryParameters != null) {
      print("queryParameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
    }
    if (options.data != null) {
      print("Body: ${options.data}");
    }
    print(
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

    if (options.headers.containsKey('requirestoken')) {
      options.headers.remove('requirestoken');
      print(
          'accessToken: ${_sharedPreferencesManager.getString(SharedPreferencesManager.keyAccessToken)}');
      String accessToken = _sharedPreferencesManager
          .getString(SharedPreferencesManager.keyAccessToken);
      options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    }
    return options;
  }

  @override
  Future onResponse(Response response) {
    print(
        "<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    print("Headers:");
    response.headers?.forEach((k, v) => print('$k: $v'));
    print("Response: ${response.data}");
    print("<-- END HTTP");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError dioError) async {
    print(
        "<-- ${dioError.message} ${(dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL')}");
    print(
        "${dioError.response != null ? dioError.response.data : 'Unknown Error'}");
    print("<-- End error");

    int responseCode = dioError.response.statusCode;
    String oldAccessToken = _sharedPreferencesManager
        .getString(SharedPreferencesManager.keyAccessToken);
    if (oldAccessToken != null &&
        responseCode == 403 &&
        _sharedPreferencesManager != null) {
      print("yo chalira cha ta ");
      _dio.interceptors.requestLock.lock();
      _dio.interceptors.responseLock.lock();
      Map map = {
        "refresh": _sharedPreferencesManager
            .getString(SharedPreferencesManager.keyRefreshToken)
      };

      ApiAuthProvider apiAuthProvider = ApiAuthProvider();
      RefreshToken token = await apiAuthProvider.refreshAuth(map);
      String newAccessToken = token.access;
      //String newRefreshToken = token.refreshToken;
      await _sharedPreferencesManager.putString(
          SharedPreferencesManager.keyAccessToken, newAccessToken);
      // await _sharedPreferencesManager.putString(
      //     SharedPreferencesManager.keyRefreshToken, newRefreshToken);

      RequestOptions options = dioError.response.request;
      options.headers.addAll({'requirestoken': true});
      _dio.interceptors.requestLock.unlock();
      _dio.interceptors.responseLock.unlock();
      return _dio.request(options.path, options: options);
    } else {
      super.onError(dioError);
    }
  }
}
