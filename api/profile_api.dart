import 'package:bees_pharmacy/model/account_profile_model.dart';
import 'package:dio/dio.dart';

class AccountProfileAPI {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://bees.prixa.live/api/ ';

  AccountProfileAPI() {
    _dio.options.baseUrl = _baseUrl;
  }

  Future<List<AccountProfileDetail>> getProfile() async {
    try {
      final response = await _dio.get(
        'accounts/',
        options: Options(headers: {'requirestoken': true}),
      );

      if (response.statusCode == 200) {
        print('Data received');
        return AccountProfileDetail.mapArray(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
