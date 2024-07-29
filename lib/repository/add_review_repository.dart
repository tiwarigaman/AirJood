import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class AddReviewRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> addReviewApi(dynamic token, Map<String, String> data) async {
    try {
      dynamic response =
      await apiAServices.postApiResponse(AppUrl.addReview, token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
