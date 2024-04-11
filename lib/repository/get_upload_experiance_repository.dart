import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/experience_model.dart';
import '../res/app_url.dart';

class GetUploadExperianceRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<ExperienceModel> getUploadExperiance(String token, int id) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          '${AppUrl.getExperianceList}/$id', token);
      return response = ExperienceModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
