import 'package:airjood/model/comment_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';

import '../res/app_url.dart';

class CommentRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<CommentsModel> getComment(String token, int reelId) async {
    try {
      dynamic response = await apiAServices.getSearchGetApiResponse(
          "${AppUrl.getComment}/$reelId?page=1", token);
      return response = CommentsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
