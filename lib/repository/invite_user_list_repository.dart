import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/invite_user_list_model.dart';
import '../res/app_url.dart';

class InviteUserListRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<InviteUserListModel> getInviteUserList(String token,int page,int planId, {String? search}) async {
    try {
      if (search == null) {
        dynamic response = await apiAServices.getSearchGetApiResponse(
            "${AppUrl.getInviteUserList}/?page=$page&invitation_plan_id=$planId", token);
        return response = InviteUserListModel.fromJson(response);
      } else {
        dynamic response = await apiAServices.getSearchGetApiResponse(
            "${AppUrl.getInviteUserList}?search=$search&invitation_plan_id=$planId", token);
        return response = InviteUserListModel.fromJson(response);
      }
    } catch (e) {
      rethrow;
    }
  }
}
