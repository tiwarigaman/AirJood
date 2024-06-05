import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/planning_list_model.dart';
import '../res/app_url.dart';

class GetPlanningListRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<PlanningListModel> getPlanningList(String token) async {
    try {
      dynamic response =
      await apiAServices.getGetApiResponse(AppUrl.addPlanning, token);
      return response = PlanningListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
