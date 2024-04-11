import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class DeleteFollowerRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future deleteFollower(String token, int id) async {
    try {
      dynamic response = await apiAServices.getDeleteApiResponse(
          '${AppUrl.deleteFollower}/$id', token);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
