import 'package:airjood/repository/get_planning_list_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../model/planning_list_model.dart';
import '../utils/utils.dart';

class GetPlanningListViewModel with ChangeNotifier {
  final myRepo = GetPlanningListRepository();

  ApiResponse<PlanningListModel> planningData = ApiResponse.loading();
  setPlanningList(ApiResponse<PlanningListModel> response) {
    planningData = response;
    notifyListeners();
  }

  Future<void> planningListGetApi(String token) async {
    setPlanningList(ApiResponse.loading());
    myRepo.getPlanningList(token).then((value) {
      setPlanningList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setPlanningList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
