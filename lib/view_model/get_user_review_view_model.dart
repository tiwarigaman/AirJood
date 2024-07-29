import 'package:airjood/model/experience_rating_model.dart';
import 'package:airjood/repository/get_user_review_respository.dart';
import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../utils/utils.dart';

class GetUserReviewViewModel with ChangeNotifier {
  final myRepo = GetUserReviewListRepository();

  ApiResponse<ExperienceRatingModel> userReviewData = ApiResponse.loading();
  setUserReviewList(ApiResponse<ExperienceRatingModel> response) {
    userReviewData = response;
    notifyListeners();
  }

  Future<void> userReviewGetApi(String token,int userId) async {
    setUserReviewList(ApiResponse.loading());
    myRepo.getUserReviewList(token,userId).then((value) {
      setUserReviewList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUserReviewList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
