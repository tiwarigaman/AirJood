import 'package:airjood/model/community_comment_model.dart';
import 'package:airjood/repository/get_community_comment_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../utils/utils.dart';

class GetCommunityCommentViewModel with ChangeNotifier {
  final myRepo = CommunityCommentRepository();

  ApiResponse<CommunityCommentModel> communityCommentData = ApiResponse.loading();
  setCommunityCommentList(ApiResponse<CommunityCommentModel> response) {
    communityCommentData = response;
    notifyListeners();
  }

  Future<void> communityCommentGetApi(String token, int communityId) async {
    setCommunityCommentList(ApiResponse.loading());
    try {
      CommunityCommentModel value = await myRepo.getCommunityComment(token, communityId);
      setCommunityCommentList(ApiResponse.completed(value));
    } catch (error) {
      setCommunityCommentList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    }
  }
}
