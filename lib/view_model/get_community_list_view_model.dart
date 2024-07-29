import 'package:airjood/model/community_list_model.dart';
import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../repository/get_community_list_repository.dart';
import '../utils/utils.dart';

class GetCommunityListViewModel with ChangeNotifier {
  final myRepo = GetCommunityListRepository();

  ApiResponse<CommunityListModel> communityData = ApiResponse.loading();
  setCommunityList(ApiResponse<CommunityListModel> response) {
    communityData = response;
    notifyListeners();
  }

  Future<void> communityListGetApi(String token,String search) async {
    setCommunityList(ApiResponse.loading());
    myRepo.getCommunityList(token,search).then((value) {
      setCommunityList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCommunityList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
