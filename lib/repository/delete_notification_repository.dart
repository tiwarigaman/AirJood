import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class DeleteNotificationRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future deleteNotification(String token, String id) async {
    try {
      dynamic response = await apiAServices.getDeleteApiResponse(
          '${AppUrl.deleteNotification}/$id', token);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
