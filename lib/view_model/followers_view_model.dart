import 'package:airjood/model/follower_model.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';

import '../repository/follower_repository.dart';
import '../utils/utils.dart';

class FollowersViewModel with ChangeNotifier {
  final myRepo = FollowerRepository();
  int _page = 1;
  List<Datum> followersList = [];

  void setPage(int page) {
    _page = page;
    notifyListeners();
  }
  void clearData() {
    followersList.clear();
    notifyListeners();
  }
  ApiResponse<FollowersModel> followerData = ApiResponse.loading();
  setFollowerList(ApiResponse<FollowersModel> response) {
    followerData = response;
    response.data?.data?.forEach((element) {
      followersList.add(element);
    });
    notifyListeners();
  }

  Future<void> followerGetApi(String token, int userId,
      {String? search,int? planId}) async {
    setFollowerList(ApiResponse.loading());
    myRepo.getFollower(token, userId, _page,search: search,planId: planId).then((value) {
      setFollowerList(ApiResponse.completed(value));
      _page++;
    }).onError((error, stackTrace) {
      setFollowerList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
