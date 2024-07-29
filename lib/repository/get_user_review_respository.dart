import 'package:airjood/model/experience_rating_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class GetUserReviewListRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<ExperienceRatingModel> getUserReviewList(String token,int userId) async {
    try {
      dynamic response =
      await apiAServices.getGetApiResponse('${AppUrl.getExperianceReview}?user_id=$userId', token);
      return response = ExperienceRatingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
