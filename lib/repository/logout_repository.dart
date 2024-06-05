import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class LogoutRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> logoutApi(dynamic token) async {
    try {
      dynamic response = await apiAServices.followPostApiResponse(AppUrl.logout, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
