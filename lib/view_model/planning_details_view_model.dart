import 'package:airjood/repository/planning_details_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../model/planning_details_model.dart';
import '../utils/utils.dart';

class PlanningDetailsViewModel with ChangeNotifier {
  final myRepo = GetPlanningDetailsRepository();

  ApiResponse<PlanningDetailsModel> getPlanningDetailsData = ApiResponse.loading();
  setPlanningDetails(ApiResponse<PlanningDetailsModel> response) {
    getPlanningDetailsData = response;
    notifyListeners();
  }

  Future<void> getPlanningDetailsApi(String token, int id) async {
    setPlanningDetails(ApiResponse.loading());
    await myRepo.getPlanningDetails(token, id).then((value) {
      setPlanningDetails(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setPlanningDetails(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
