import 'package:airjood/model/reels_model.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../repository/reels_repository.dart';
import '../utils/utils.dart';

class ReelsViewModel with ChangeNotifier {
  final myRepo = ReelsRepository();
  List<ReelsData> laqtaData = [];

  ApiResponse<ReelsModel> reelsData = ApiResponse.loading();

  setReelsList(ApiResponse<ReelsModel> response) {
    reelsData = response;
    laqtaData.clear();
    response.data?.data?.forEach((element) {
      laqtaData.add(element);
    });
    notifyListeners();
  }

  setReelsList2(ApiResponse<ReelsModel> response) {
    reelsData = response;
    response.data?.data?.forEach((element) {
      laqtaData.add(element);
    });
    notifyListeners();
  }

  Future<void> reelsGetApi(String token, int page) async {
    setReelsList(ApiResponse.loading());
    await myRepo.getReels(token, page).then((value) {
      setReelsList(ApiResponse.completed(value));
      //Utils.tostMessage('$value');
    }).onError((error, stackTrace) {
      setReelsList(ApiResponse.error(error.toString()));
      throw error!;
      Utils.tostMessage('$error');
    });
  }

  void likeUpdates(bool liked, int id) {
    if (liked == true) {
      for (var element in laqtaData) {
        if (element.id == id) {
          element.likeCount = (element.likeCount ?? 0) - 1;
        }
      }
    } else {
      for (var element in laqtaData) {
        if (element.id == id) {
          element.likeCount = (element.likeCount ?? 0) + 1;
        }
      }
    }
    for (var element in laqtaData) {
      if (element.id == id) {
        element.liked = !(element.liked ?? true);
      }
    }
    notifyListeners();
  }

  void commentUpdates(int id) {
    for (var element in laqtaData) {
      if (element.id == id) {
        element.commentCount = (element.commentCount ?? 0) + 1;
      }
    }
    notifyListeners();
  }

  Future<void> reelsUserGetApi(int userId, String token, int page) async {
    setReelsList(ApiResponse.loading());
    await myRepo.getUserReels(userId, token, page).then((value) {
      if (page == 1) {
        setReelsList(ApiResponse.completed(value));
      } else {
        setReelsList2(ApiResponse.completed(value));
      }
      //Utils.tostMessage('$value');
    }).onError((error, stackTrace) {
      setReelsList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
