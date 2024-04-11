import 'package:airjood/repository/follow_repository.dart';
import 'package:flutter/widgets.dart';
import '../utils/utils.dart';

class FollowViewModel extends ChangeNotifier {
  final myRepo = FollowRepository();
  bool _followLoading = false;

  bool get followsLoading => _followLoading;

  followLoading(bool val) {
    _followLoading = val;
    notifyListeners();
  }

  Future<void> followApi(
      dynamic token, int userId, String follow, BuildContext context) async {
    followLoading(true);
    myRepo.followApi(token, userId, follow).then((value) {
      followLoading(false);
      //Utils.tostMessage('${value['message']}');
    }).onError((error, stackTrace) {
      followLoading(false);
      Utils.tostMessage('$error');
    });
  }
}
