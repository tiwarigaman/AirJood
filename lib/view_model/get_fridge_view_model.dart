import 'package:airjood/repository/get_fridge_repository.dart';
import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../model/fridge_model.dart';
import '../utils/utils.dart';

class FridgeViewModel with ChangeNotifier {
  final myRepo = FridgeRepository();

  ApiResponse<FridgeModel> fridgeData = ApiResponse.loading();
  setFridge(ApiResponse<FridgeModel> response) {
    fridgeData = response;
    notifyListeners();
  }

  Future<void> fridgeGetApi(String token) async {
    setFridge(ApiResponse.loading());
    await myRepo.getFridge(token).then((value) {
      setFridge(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setFridge(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
