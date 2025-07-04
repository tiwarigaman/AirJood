import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class FollowRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> followApi(
    dynamic token,
    int userId,
    String follow,
  ) async {
    try {
      dynamic response = await apiAServices.followPostApiResponse(
          "${AppUrl.follow}/$userId/$follow", token);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
