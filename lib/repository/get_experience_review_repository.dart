import 'package:airjood/model/experience_rating_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class GetExperienceReviewListRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<ExperienceRatingModel> getExperienceReviewList(String token,int experienceId) async {
    try {
      dynamic response =
      await apiAServices.getGetApiResponse('${AppUrl.getExperianceReview}?experience_id=$experienceId', token);
      return response = ExperienceRatingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
