import 'dart:io';

import 'package:airjood/repository/add_community_comment_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import 'get_community_comment_view_model.dart';

class AddCommunityCommentViewModel extends ChangeNotifier {
  final myRepo = AddCommunityCommentRepository();
  bool _addCommunityCommentLoading = false;

  bool get addCommunityCommentsLoading => _addCommunityCommentLoading;

  addCommunityCommentLoading(bool val) {
    _addCommunityCommentLoading = val;
    notifyListeners();
  }

  Future<void> addCommunityCommentApi(dynamic token, Map<String, String> data,
      BuildContext context,{File? attachment , int? communityId}) async {
    addCommunityCommentLoading(true);
    myRepo.addCommunityCommentApi(token, data, attachment: attachment).then((value) {
      addCommunityCommentLoading(false);
      Provider.of<GetCommunityCommentViewModel>(context, listen: false)
          .communityCommentGetApi(token, communityId!);
      Utils.toastMessage('${value['message']}');
    }).onError((error, stackTrace) {
      addCommunityCommentLoading(false);
      Utils.toastMessage('$error');
    });
  }
}
