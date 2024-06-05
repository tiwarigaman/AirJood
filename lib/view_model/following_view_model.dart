import 'package:airjood/model/following_model.dart';
import 'package:airjood/repository/following_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';

import '../utils/utils.dart';

class FollowingViewModel with ChangeNotifier {
  final myRepo = FollowingRepository();
  int _page = 1;
  List<Datum> followingList = [];

  void setPage(int page) {
    _page = page;
    notifyListeners();
  }
  void clearData() {
    followingList.clear();
    notifyListeners();
  }
  ApiResponse<FollowingModel> followingData = ApiResponse.loading();
  setFollowingList(ApiResponse<FollowingModel> response) {
    followingData = response;
    response.data?.data?.forEach((element) {
      followingList.add(element);
    });
    notifyListeners();
  }

  Future<void> followingGetApi(String token, int userId,
      {String? search,int? planId}) async {
    setFollowingList(ApiResponse.loading());
    myRepo.getFollowing(token, userId, _page,planId: planId, search: search).then((value) {
      setFollowingList(ApiResponse.completed(value));
      _page++;
    }).onError((error, stackTrace) {
      setFollowingList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
