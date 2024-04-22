import 'package:airjood/model/follower_model.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';

import '../repository/follower_repository.dart';
import '../utils/utils.dart';

class FollowersViewModel with ChangeNotifier {
  final myRepo = FollowerRepository();

  ApiResponse<FollowersModel> followerData = ApiResponse.loading();
  setFollowerList(ApiResponse<FollowersModel> response) {
    followerData = response;
    notifyListeners();
  }

  Future<void> followerGetApi(String token, int userId,
      {String? search}) async {
    setFollowerList(ApiResponse.loading());
    myRepo.getFollower(token, userId, search: search).then((value) {
      setFollowerList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setFollowerList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
