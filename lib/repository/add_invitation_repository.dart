import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class AddInvitationRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> addInvitationApi(dynamic token, Map<String, String> data) async {
    try {
      dynamic response =
      await apiAServices.postApiResponse(AppUrl.addInvitation, token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
