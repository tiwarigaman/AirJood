import 'package:airjood/model/home_reels_model.dart';
import 'package:airjood/model/reels_model.dart';
import 'package:airjood/repository/home_reels_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';

import '../utils/utils.dart';

class HomeReelsViewModel with ChangeNotifier {
  final myRepo = HomeReelsRepository();
  List<Datum> mainReelsData = [];
  int _page = 1;

  void setPage(int page) {
    _page = page;
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

  Future<void> homeReelsGetApi(String token) async {
    setHomeReelsList(ApiResponse.loading());
    await myRepo.getHomeReels(token, _page).then((value) {
      setHomeReelsList(ApiResponse.completed(value));
      _page++;
      //Utils.tostMessage('$value');
    }).onError((error, stackTrace) {
      setHomeReelsList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
