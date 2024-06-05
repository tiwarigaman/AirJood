import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/country_model.dart';
import '../res/app_url.dart';

class CountryRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<CountryModel> getCountry(String token) async {
    try {
      dynamic response =
      await apiAServices.getGetApiResponse(AppUrl.getCountry, token);
      return response = CountryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
