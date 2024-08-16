import 'package:airjood/model/get_experiance_model.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../repository/get_experiance_list_repository.dart';
import '../utils/utils.dart';

class GetExperianceListViewModel with ChangeNotifier {
  final myRepo = GetExperianceListRepository();

  final List<Datum> _data2 = [];

  List<Datum> get data2 => _data2;

  ApiResponse<GetExperienceModel> getExperianceData = ApiResponse.loading();

  setGetExperianceList(ApiResponse<GetExperienceModel> response) {
    getExperianceData = response;
    _data2.clear();
    if (response.data?.data != null) {
      for (var element in response.data!.data!) {
        _data2.add(element);
      }
    }
    notifyListeners();
  }

  void likeUpdates(bool liked, int id, int index) {
    if (liked == true) {
      for (var element in _data2) {
        if (element.reel?[index].id == id) {
          element.reel?[index].likeCount =
              (element.reel?[index].likeCount ?? 0) - 1;
        }
      }
    } else {
      for (var element in _data2) {
        if (element.reel?[index].id == id) {
          element.reel?[index].likeCount =
              (element.reel?[index].likeCount ?? 0) + 1;
        }
      }
    }
    for (var element in _data2) {
      if (element.reel?[index].id == id) {
        element.reel?[index].liked = !(element.reel?[index].liked ?? true);
      }
    }
    notifyListeners();
  }

  void commentUpdates(int id, int index) {
    for (var element in _data2) {
      if (element.reel?[index].id == id) {
        element.reel?[index].commentCount =
            (element.reel?[index].commentCount ?? 0) + 1;
      }
    }
    notifyListeners();
  }

  Future<void> getExperianceListApi(String token, int page) async {
    setGetExperianceList(ApiResponse.loading());
    await myRepo.getExperianceList(token, page).then((value) {
      setGetExperianceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setGetExperianceList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }

  Future<void> getReelsUserExperianceListApi(
      int userId, String token, int page) async {
    setGetExperianceList(ApiResponse.loading());
    await myRepo.getReelsUserExperianceList(userId, token, page).then((value) {
      setGetExperianceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setGetExperianceList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
