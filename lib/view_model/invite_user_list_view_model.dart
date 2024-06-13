import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../model/invite_user_list_model.dart';
import '../repository/invite_user_list_repository.dart';
import '../utils/utils.dart';

class InviteUserListViewModel with ChangeNotifier {
  final myRepo = InviteUserListRepository();
  int _page = 1;
  List<Datum> invitedList = [];

  void setPage(int page) {
    _page = page;
    notifyListeners();
  }
  void clearData() {
    invitedList.clear();
    notifyListeners();
  }
  ApiResponse<InviteUserListModel> inviteUserListData = ApiResponse.loading();

  setInviteUserList(ApiResponse<InviteUserListModel> response) {
    inviteUserListData = response;
    response.data?.data?.forEach((element) {
      invitedList.add(element);
    });
    notifyListeners();
  }

  Future<void> inviteUserListGetApi(String token,int planId,{String? search}) async {
    setInviteUserList(ApiResponse.loading());
    try {
      final value = await myRepo.getInviteUserList(token, _page, planId,search: search);
      setInviteUserList(ApiResponse.completed(value));
      _page++;
    } catch (error) {
      setInviteUserList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
      rethrow;
    }
  }
}
