import 'package:airjood/model/notification_list_model.dart';
import 'package:airjood/repository/notification_list_repository.dart';
import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../utils/utils.dart';

class NotificationListViewModel with ChangeNotifier {
  final myRepo = NotificationListRepository();
  int _page = 1;

  void setPage(int page) {
    _page = page;
    notifyListeners();
  }
  ApiResponse<NotificationModel> notificationListData = ApiResponse.loading();

  setNotificationList(ApiResponse<NotificationModel> response) {
    notificationListData = response;
    notifyListeners();
  }

  Future<void> notificationListGetApi(String token) async {
    setNotificationList(ApiResponse.loading());
    try {
      final value = await myRepo.getNotificationList(token, _page);
      setNotificationList(ApiResponse.completed(value));
      // _page++;
    } catch (error) {
      setNotificationList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
      rethrow;
    }
  }
}
