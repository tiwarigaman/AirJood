import 'package:airjood/model/notification_list_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class NotificationListRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<NotificationModel> getNotificationList(String token,int page) async {
    try {
        dynamic response = await apiAServices.getSearchGetApiResponse(
            "${AppUrl.getNotification}/?page=$page", token);
        return response = NotificationModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
