import 'package:airjood/model/profile_model.dart';
import 'package:airjood/repository/get_profile_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../utils/utils.dart';

class ProfileViewModel with ChangeNotifier {
  final myRepo = ProfileRepository();

  ApiResponse<ProfileModel> profileData = ApiResponse.loading();
  setProfile(ApiResponse<ProfileModel> response) {
    profileData = response;
    notifyListeners();
  }

  Future<void> profileGetApi(String token,int userId) async {
    setProfile(ApiResponse.loading());
    myRepo.getProfile(token,userId).then((value) {
      setProfile(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProfile(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
