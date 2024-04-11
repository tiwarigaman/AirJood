import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class AddRemoveLikeRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> addRemoveLikesApi(
    dynamic token,
    Map<String, dynamic> data,
    int commentId,
  ) async {
    try {
      dynamic response = await apiAServices.likePostApiResponse(
          "${AppUrl.addRemoveLike}/$commentId/like", token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addReelsRemoveLikesApi(
    dynamic token,
    Map<String, dynamic> data,
    int reelsId,
  ) async {
    try {
      dynamic response = await apiAServices.likePostApiResponse(
          "${AppUrl.addReelsRemoveLike}/$reelsId/like", token, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
