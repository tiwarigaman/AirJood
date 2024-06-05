
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class AddReelsPlanningRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> addReelsPlanningApi(
      String token, Map<String, String> data) async {
    try {
      dynamic response = await apiAServices.postApiResponse(
          AppUrl.addReelsPlanning, token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
