import 'package:airjood/model/followers_model.dart';
import 'package:airjood/repository/followers_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';

import '../utils/utils.dart';

class FollowersViewModel with ChangeNotifier {
  final myRepo = FollowersRepository();

  ApiResponse<FollowersModel> followersData = ApiResponse.loading();
  setFollowersList(ApiResponse<FollowersModel> response) {
    followersData = response;
    notifyListeners();
  }

  Future<void> followersGetApi(String token, int reelId) async {
    setFollowersList(ApiResponse.loading());
    myRepo.getFollowers(token, reelId).then((value) {
      setFollowersList(ApiResponse.completed(value));
      //Utils.tostMessage(value.data.toString());
    }).onError((error, stackTrace) {
      setFollowersList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
