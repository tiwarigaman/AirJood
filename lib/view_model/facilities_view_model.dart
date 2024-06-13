import 'package:airjood/model/facilities_model.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../repository/facilities_repository.dart';
import '../utils/utils.dart';

class FacilitiesViewModel with ChangeNotifier {
  final myRepo = FacilitiesRepository();

  ApiResponse<List<FacilitiesModel>> facilitiesData = ApiResponse.loading();
  setFacilitiesDataList(ApiResponse<List<FacilitiesModel>> response) {
    facilitiesData = response;
    notifyListeners();
  }

  Future<void> facilitiesGetApi(String token) async {
    setFacilitiesDataList(ApiResponse.loading());
    myRepo.getFacilities(token).then((value) {
      setFacilitiesDataList(ApiResponse.completed(value));
      //Utils.tostMessage(value[0].mood.toString());
    }).onError((error, stackTrace) {
      setFacilitiesDataList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
