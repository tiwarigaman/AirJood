import 'package:airjood/model/mood_model.dart';
import 'package:airjood/repository/mood_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../utils/utils.dart';

class MoodViewModel with ChangeNotifier {
  final myRepo = MoodRepository();

  ApiResponse<List<MoodModel>> moodData = ApiResponse.loading();
  setMoodList(ApiResponse<List<MoodModel>> response) {
    moodData = response;
    notifyListeners();
  }

  Future<void> moodGetApi(String token) async {
    setMoodList(ApiResponse.loading());
    myRepo.getMood(token).then((value) {
      setMoodList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoodList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
