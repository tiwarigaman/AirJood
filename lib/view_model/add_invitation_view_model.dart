import 'package:flutter/widgets.dart';
import '../repository/add_invitation_repository.dart';
import '../utils/utils.dart';

class AddInvitationViewModel extends ChangeNotifier {
  final myRepo = AddInvitationRepository();
  bool _addInvitationLoading = false;

  bool get addInvitationLoading => _addInvitationLoading;

  addInvitationsLoading(bool val) {
    _addInvitationLoading = val;
    notifyListeners();
  }

  Future<void> addInvitationApi(dynamic token, Map<String, String> data,
      BuildContext context) async {
    addInvitationsLoading(true);
    myRepo.addInvitationApi(token, data).then((value) {
      addInvitationsLoading(false);
      Utils.toastMessage('${value['message']}');
    }).onError((error, stackTrace) {
      addInvitationsLoading(false);
      Utils.toastMessage('$error');
    });
  }
}
