import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class FollowRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> followApi(
    dynamic token,
    int userId,
    bool follow,
  ) async {
    print('${AppUrl.follow}/$userId/$follow');
    try {
      dynamic response = await apiAServices.followPostApiResponse(
          "${AppUrl.follow}/$userId/$follow", token);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
