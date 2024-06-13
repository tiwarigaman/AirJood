import 'package:airjood/repository/delete_notification_repository.dart';
import 'package:airjood/view_model/notification_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';

class DeleteNotificationViewModel with ChangeNotifier {
  final myRepo = DeleteNotificationRepository();

  Future<void> deleteNotificationApi(
      String token, String id, BuildContext context) async {
    myRepo.deleteNotification(token, id).then((value) {
      Utils.toastMessage('${value['message']}');
      Provider.of<NotificationListViewModel>(context, listen: false).notificationListGetApi(token);
    }).onError((error, stackTrace) {
      Utils.toastMessage('$error');
    });
  }
}
