import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class DeletePlanningReelsRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> deletePlanningReelsRepositoryApi(dynamic token, Map<String, String> data) async {
    try {
      dynamic response =
      await apiAServices.postApiResponse(AppUrl.deletePlanningReels, token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
