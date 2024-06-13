
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class ReadNotificationRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> readNotificationApi(
      String token, Map<String, String> data) async {
    try {
      dynamic response = await apiAServices.postApiResponse(
          AppUrl.readUnreadNotification, token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
