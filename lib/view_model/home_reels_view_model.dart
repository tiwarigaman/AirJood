import 'package:airjood/model/home_reels_model.dart';
import 'package:airjood/repository/home_reels_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../data/response/api_response.dart';

import '../utils/utils.dart';
import 'follow_view_model.dart';
import 'user_view_model.dart';

class HomeReelsViewModel with ChangeNotifier {
  final myRepo = HomeReelsRepository();
  List<Datum> mainReelsData = [];
  int _page = 1;

  void setPage(int page) {
    _page = page;
    notifyListeners();
  }

  void clearData() {
    mainReelsData.clear();
    notifyListeners();
  }

  ApiResponse<HomeReelsModel> homeReelsData = ApiResponse.loading();

  setHomeReelsList(ApiResponse<HomeReelsModel> response) {
    // homeReelsData = response;
    response.data?.data?.forEach((element) {
      mainReelsData.add(element);
    });
    notifyListeners();
  }

  void likeUpdates(bool liked, int id) {
    if (liked == true) {
      for (var element in mainReelsData) {
        if (element.reelId == id) {
          element.reel?.likeCount = (element.reel?.likeCount ?? 0) - 1;
        }
      }
    } else {
      for (var element in mainReelsData) {
        if (element.reelId == id) {
          element.reel?.likeCount = (element.reel?.likeCount ?? 0) + 1;
        }
      }
    }
    for (var element in mainReelsData) {
      if (element.reelId == id) {
        element.reel?.liked = !(element.reel?.liked ?? true);
      }
    }
    notifyListeners();
  }

  void commentUpdates(int id) {
    for (var element in mainReelsData) {
      if (element.reelId == id) {
        element.reel?.commentCount = (element.reel?.commentCount ?? 0) + 1;
      }
    }
    notifyListeners();
  }

  void handleFollowers(BuildContext context, int userId, bool isFollow) {
    for (var element in mainReelsData) {
      if (userId == element.user?.id) {
        element.user?.isFollower = !(element.user?.isFollower ?? false);
      }
    }
    UserViewModel().getToken().then((token) async {
      await Provider.of<FollowViewModel>(context, listen: false).followApi(
        token!,
        userId,
        isFollow ? '0' : '1',
        context,
      );
    });
    notifyListeners();
  }

  Future<void> homeReelsGetApi(String token, {int? tabIndex}) async {
    setHomeReelsList(ApiResponse.loading());
    await myRepo.getHomeReels(token, _page, tabIndex: tabIndex).then((value) {
      setHomeReelsList(ApiResponse.completed(value));
      _page++;
    }).onError((error, stackTrace) {
      setHomeReelsList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
