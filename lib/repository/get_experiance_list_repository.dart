import 'package:airjood/model/get_experiance_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class GetExperianceListRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<GetExperienceModel> getExperianceList(String token, int page) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          '${AppUrl.getExperianceList}?page=$page', token);
      return response = GetExperienceModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<GetExperienceModel> getReelsUserExperianceList(
      int userId, String token, int page) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          '${AppUrl.getExperianceList}?page=$page&&user=$userId', token);
      return response = GetExperienceModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
