import 'package:airjood/model/following_model.dart';
import 'package:airjood/repository/following_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';

import '../utils/utils.dart';

class FollowingViewModel with ChangeNotifier {
  final myRepo = FollowingRepository();

  ApiResponse<FollowingModel> followingData = ApiResponse.loading();
  setFollowingList(ApiResponse<FollowingModel> response) {
    followingData = response;
    notifyListeners();
  }

  Future<void> followingGetApi(String token, int reelId,
      {String? search}) async {
    setFollowingList(ApiResponse.loading());
    myRepo.getFollowing(token, reelId, search: search).then((value) {
      setFollowingList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setFollowingList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
