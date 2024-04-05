import 'package:airjood/model/comment_model.dart';
import 'package:airjood/model/followers_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';

import '../res/app_url.dart';

class FollowersRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<FollowersModel> getFollowers(String token, int userId) async {
    try {
      dynamic response = await apiAServices.getSearchGetApiResponse(
          "${AppUrl.getFollowers}/$userId", token);
      return response = FollowersModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
