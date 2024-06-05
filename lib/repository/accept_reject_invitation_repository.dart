
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class AcceptRejectInvitationRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> acceptRejectInvitationApi(
      String token, Map<String, String> data) async {
    try {
      dynamic response = await apiAServices.postApiResponse(
          AppUrl.acceptRejectInvitation, token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
