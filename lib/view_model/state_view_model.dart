import 'package:airjood/model/state_model.dart';
import 'package:airjood/repository/state_repository.dart';
import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../utils/utils.dart';

class StateViewModel with ChangeNotifier {
  final myRepo = StateRepository();

  ApiResponse<StateModel> stateData = ApiResponse.loading();

  setStateList(ApiResponse<StateModel> response) {
    stateData = response;
    notifyListeners();
  }

  Future<void> stateGetApi(String token, String countryId) async {
    setStateList(ApiResponse.loading());
    try {
      final value = await myRepo.getState(token, countryId);
      setStateList(ApiResponse.completed(value));
    } catch (error) {
      setStateList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
      rethrow;
    }
  }
}
