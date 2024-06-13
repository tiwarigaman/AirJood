import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/read_unread_notification_repository.dart';
import '../utils/utils.dart';
import 'notification_list_view_model.dart';

class ReadNotificationViewModel with ChangeNotifier {
  final myRepo = ReadNotificationRepository();

  bool _readNotificationLoading = false;

  bool get readNotificationLoadings => _readNotificationLoading;

  readNotificationLoading(bool val) {
    _readNotificationLoading = val;
    notifyListeners();
  }

  Future<void> readUnreadNotificationApi(String token, Map<String, String> data, BuildContext context) async {
    readNotificationLoading(true);
    myRepo.readNotificationApi(token, data).then((value) {
      readNotificationLoading(false);
      Provider.of<NotificationListViewModel>(context, listen: false)
          .notificationListGetApi(token);
      // Utils.tostMessage('${value['message']}');
    }).onError((error, stackTrace) {
      readNotificationLoading(false);
      Utils.toastMessage('$error');
    });
  }
}
