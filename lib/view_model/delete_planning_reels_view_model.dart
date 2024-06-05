import 'package:airjood/view_model/planning_details_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../repository/delete_planning_reels_repository.dart';
import '../utils/utils.dart';

class DeletePlanningReelsViewModel extends ChangeNotifier {
  final myRepo = DeletePlanningReelsRepository();
  bool _deletePlanningReelsLoading = false;

  bool get deletePlanningReelsLoading => _deletePlanningReelsLoading;

  deletePlanningReelsLoadings(bool val) {
    _deletePlanningReelsLoading = val;
    notifyListeners();
  }

  Future<void> deletePlanningReelsApi(dynamic token, Map<String, String> data,
      int planId,BuildContext context) async {
    deletePlanningReelsLoadings(true);
    myRepo.deletePlanningReelsRepositoryApi(token, data).then((value) {
      deletePlanningReelsLoadings(false);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Provider.of<PlanningDetailsViewModel>(context, listen: false)
          .getPlanningDetailsApi(token, planId);
      Utils.tostMessage('${value['message']}');
    }).onError((error, stackTrace) {
      deletePlanningReelsLoadings(false);
      Utils.tostMessage('$error');
    });
  }
}
