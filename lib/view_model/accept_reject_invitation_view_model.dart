import 'package:airjood/repository/accept_reject_invitation_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import 'notification_list_view_model.dart';

class AcceptRejectInvitationViewModel with ChangeNotifier {
  final myRepo = AcceptRejectInvitationRepository();

  bool _acceptRejectInvitationLoading = false;

  bool get acceptRejectInvitationLoadings => _acceptRejectInvitationLoading;

  acceptRejectInvitationLoading(bool val) {
    _acceptRejectInvitationLoading = val;
    notifyListeners();
  }

  Future<void> acceptRejectInvitationApi(String token, Map<String, String> data, BuildContext context) async {
    acceptRejectInvitationLoading(true);
    myRepo.acceptRejectInvitationApi(token, data).then((value) {
      acceptRejectInvitationLoading(false);
      Navigator.pop(context);
      Provider.of<NotificationListViewModel>(context, listen: false)
          .notificationListGetApi(token);
      Utils.toastMessage('${value['message']}');
    }).onError((error, stackTrace) {
      acceptRejectInvitationLoading(false);
      Utils.toastMessage('$error');
    });
  }
}
