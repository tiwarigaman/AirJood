import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class JoinCommunityRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> joinCommunityApi(dynamic token, Map<String, String> data) async {
    try {
      dynamic response =
      await apiAServices.postApiResponse(AppUrl.joinCommunity, token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
