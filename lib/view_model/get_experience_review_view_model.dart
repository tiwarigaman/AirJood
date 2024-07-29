import 'package:airjood/model/experience_rating_model.dart';
import 'package:airjood/repository/get_experience_review_repository.dart';
import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../utils/utils.dart';

class GetExperienceReviewViewModel with ChangeNotifier {
  final myRepo = GetExperienceReviewListRepository();

  ApiResponse<ExperienceRatingModel> experienceReviewData = ApiResponse.loading();
  setExperienceReviewList(ApiResponse<ExperienceRatingModel> response) {
    experienceReviewData = response;
    notifyListeners();
  }

  Future<void> experienceReviewGetApi(String token,int experienceId) async {
    setExperienceReviewList(ApiResponse.loading());
    myRepo.getExperienceReviewList(token,experienceId).then((value) {
      setExperienceReviewList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setExperienceReviewList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
