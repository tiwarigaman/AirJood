import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/planning_details_model.dart';
import '../res/app_url.dart';

class GetPlanningDetailsRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<PlanningDetailsModel> getPlanningDetails(String token, int id) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          '${AppUrl.getPlanningDetails}/$id', token);
      return response = PlanningDetailsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
