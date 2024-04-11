import 'package:airjood/model/following_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';

import '../res/app_url.dart';

class FollowingRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<FollowingModel> getFollowing(String token, int userId,
      {String? search}) async {
    try {
      if (search == null) {
        dynamic response = await apiAServices.getSearchGetApiResponse(
            "${AppUrl.getFollowing}/$userId", token);
        return response = FollowingModel.fromJson(response);
      } else {
        dynamic response = await apiAServices.getSearchGetApiResponse(
            "${AppUrl.getFollowing}/?search=$search", token);
        return response = FollowingModel.fromJson(response);
      }
    } catch (e) {
      rethrow;
    }
  }
}
