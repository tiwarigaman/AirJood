import 'package:airjood/model/community_details_model.dart';
import 'package:airjood/repository/get_community_details_repository.dart';
import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../utils/utils.dart';

class GetCommunityDetailsViewModel with ChangeNotifier {
  final myRepo = GetCommunityDetailsRepository();

  ApiResponse<CommunityDetailsModel> getCommunityDetailsData = ApiResponse.loading();
  setGetCommunityDetails(ApiResponse<CommunityDetailsModel> response) {
    getCommunityDetailsData = response;
    notifyListeners();
  }

  Future<void> getCommunityDetailsApi(String token, int id) async {
    setGetCommunityDetails(ApiResponse.loading());
    await myRepo.getCommunityDetails(token, id).then((value) {
      setGetCommunityDetails(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setGetCommunityDetails(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
