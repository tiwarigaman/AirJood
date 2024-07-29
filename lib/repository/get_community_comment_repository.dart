import 'package:airjood/model/community_comment_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';

import '../res/app_url.dart';

class CommunityCommentRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<CommunityCommentModel> getCommunityComment(String token, int communityId) async {
    try {
      dynamic response = await apiAServices.getSearchGetApiResponse(
          "${AppUrl.getCommunityComment}?community_id=$communityId", token);
      return response = CommunityCommentModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
