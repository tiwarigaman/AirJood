import 'dart:io';
import 'package:airjood/repository/add_planning_repository.dart';
import 'package:airjood/view_model/planning_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import 'get_planning_list_view_model.dart';

class AddPlanningViewModel with ChangeNotifier {
  final myRepo = AddPlanningRepository();

  bool _addPlanningLoading = false;

  bool get addPlanningLoadings => _addPlanningLoading;

  addPlanningLoading(bool val) {
    _addPlanningLoading = val;
    notifyListeners();
  }

  Future<void> addPlanningApi(
      String token, Map<String, String> data, File image, BuildContext context,
      {bool? edit, int? planId}) async {
    addPlanningLoading(true);
    myRepo
        .addPlanningApi(token, data, image, edit: edit, planId: planId)
        .then((value) {
      addPlanningLoading(false);
      Navigator.pop(context);
      Provider.of<GetPlanningListViewModel>(context, listen: false)
          .planningListGetApi(token);
      if (planId != null) {
        Provider.of<PlanningDetailsViewModel>(context, listen: false)
            .getPlanningDetailsApi(token, planId);
      }
      Utils.toastMessage('${value['message']}');
    }).onError((error, stackTrace) {
      addPlanningLoading(false);
      Utils.toastMessage('$error');
    });
  }
}
