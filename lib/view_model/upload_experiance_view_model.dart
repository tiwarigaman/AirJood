import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../model/experience_model.dart';
import '../repository/get_upload_experiance_repository.dart';
import '../utils/utils.dart';

class UploadExperianceViewModel with ChangeNotifier {
  final myRepo = GetUploadExperianceRepository();

  ApiResponse<ExperienceModel> getUploadExperianceData = ApiResponse.loading();
  setGetUploadExperianceList(ApiResponse<ExperienceModel> response) {
    getUploadExperianceData = response;
    notifyListeners();
  }

  Future<void> getUploadExperianceListApi(String token, int id) async {
    setGetUploadExperianceList(ApiResponse.loading());
    await myRepo.getUploadExperiance(token, id).then((value) {
      setGetUploadExperianceList(ApiResponse.completed(value));
      //Utils.tostMessage('$value');
    }).onError((error, stackTrace) {
      setGetUploadExperianceList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
