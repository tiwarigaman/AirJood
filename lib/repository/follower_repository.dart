import 'package:airjood/model/follower_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';

import '../res/app_url.dart';

class FollowerRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<FollowersModel> getFollower(String token, int userId,
      {String? search}) async {
    try {
      if (search == null) {
        print('${AppUrl.getFollower}/$userId');
        dynamic response = await apiAServices.getSearchGetApiResponse(
            '${AppUrl.getFollower}/$userId', token);
        return response = FollowersModel.fromJson(response);
      } else {
        print('${AppUrl.getFollower}/?search=$search');
        dynamic response = await apiAServices.getSearchGetApiResponse(
            '${AppUrl.getFollower}/?search=$search', token);
        return response = FollowersModel.fromJson(response);
      }
    } catch (e) {
      rethrow;
    }
  }
}
