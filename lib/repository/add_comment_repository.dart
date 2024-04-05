import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class AddCommentRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> addCommentApi(dynamic token, Map<String, String> data) async {
    try {
      dynamic response =
          await apiAServices.postApiResponse(AppUrl.addComment, token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
