import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/facilities_model.dart';
import '../res/app_url.dart';

class FacilitiesRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<List<FacilitiesModel>> getFacilities(String token) async {
    try {
      dynamic response =
          await apiAServices.getGetApiResponse(AppUrl.getFacilities, token);
      return response = facilitiesModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
