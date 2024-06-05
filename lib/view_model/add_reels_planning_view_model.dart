import 'package:flutter/material.dart';
import '../repository/add_reels_planning_repository.dart';
import '../utils/utils.dart';
import '../view/navigation_view/planning_view/planning_details_screen.dart';

class AddReelsPlanningViewModel with ChangeNotifier {
  final myRepo = AddReelsPlanningRepository();

  bool _addReelsPlanningLoading = false;

  bool get addReelsPlanningLoadings => _addReelsPlanningLoading;

  addReelsPlanningLoading(bool val) {
    _addReelsPlanningLoading = val;
    notifyListeners();
  }

  Future<void> addReelsPlanningApi(int id,String token, Map<String, String> data, BuildContext context) async {
    addReelsPlanningLoading(true);
    myRepo.addReelsPlanningApi(token, data).then((value) {
      addReelsPlanningLoading(false);
      Utils.tostMessage('${value['message']}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlanningDetailsScreen(
            id: id,
          ),
        ),
      );
    }).onError((error, stackTrace) {
      addReelsPlanningLoading(false);
      Utils.tostMessage('$error');
    });
  }
}
