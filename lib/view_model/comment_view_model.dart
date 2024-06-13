import 'package:airjood/model/comment_model.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../repository/comment_repository.dart';
import '../utils/utils.dart';

class CommentViewModel with ChangeNotifier {
  final myRepo = CommentRepository();

  ApiResponse<CommentsModel> commentData = ApiResponse.loading();
  setCommentList(ApiResponse<CommentsModel> response) {
    commentData = response;
    notifyListeners();
  }

  Future<void> commentGetApi(String token, int reelId) async {
    setCommentList(ApiResponse.loading());
    myRepo.getComment(token, reelId).then((value) {
      setCommentList(ApiResponse.completed(value));
      //Utils.tostMessage(value.data.toString());
    }).onError((error, stackTrace) {
      setCommentList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
