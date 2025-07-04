import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class DeleteFollowerRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future deleteFollower(String token, int id) async {
    print('${AppUrl.deleteFollower}/$id');
    try {
      dynamic response = await apiAServices.followPostApiResponse(
          '${AppUrl.deleteFollower}/$id', token);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
