import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class DeleteExperianceRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future deleteExperiance(String token, int id) async {
    try {
      dynamic response = await apiAServices.getDeleteApiResponse(
          '${AppUrl.deleteExperiance}/$id', token);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future deleteReels(String token, int id) async {
    try {
      dynamic response = await apiAServices.getDeleteApiResponse(
          '${AppUrl.deleteReels}/$id', token);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
