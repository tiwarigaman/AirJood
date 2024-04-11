import 'package:airjood/repository/delete_follower_repository.dart';
import 'package:airjood/view_model/user_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';
import 'followers_view_model.dart';

class DeleteFollowerViewModel with ChangeNotifier {
  final myRepo = DeleteFollowerRepository();

  Future<void> deleteFollowerApi(
      String token, int id, int loginUserId,BuildContext context) async {
    myRepo.deleteFollower(token, id).then((value) {
      UserViewModel().getToken().then((value) {
        Provider.of<FollowersViewModel>(context, listen: false)
            .followerGetApi(value!, loginUserId);
      });
    }).onError((error, stackTrace) {
      Utils.tostMessage('$error');
    });
  }
}
