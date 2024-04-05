import 'package:airjood/repository/add_remove_like_repository.dart';
import 'package:airjood/view_model/user_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import 'comment_view_model.dart';
import 'home_reels_view_model.dart';

class AddRemoveLikeViewModel extends ChangeNotifier {
  final myRepo = AddRemoveLikeRepository();
  bool _addRemoveLikeLoading = false;

  bool get addRemoveLikeLoading => _addRemoveLikeLoading;

  addRemoveLikesLoading(bool val) {
    _addRemoveLikeLoading = val;
    notifyListeners();
  }

  Future<void> addRemoveLikeApi(dynamic token, Map<String, dynamic> data,
      int commentId, BuildContext context) async {
    addRemoveLikesLoading(true);
    myRepo.addRemoveLikesApi(token, data, commentId).then((value) {
      addRemoveLikesLoading(false);
      //Utils.tostMessage('${value['message']}');
    }).onError((error, stackTrace) {
      addRemoveLikesLoading(false);
      Utils.tostMessage('$error');
    });
  }

  bool _addReelsRemoveLikeLoading = false;

  bool get addReelsRemoveLikeLoading => _addReelsRemoveLikeLoading;

  addReelsRemoveLikesLoading(bool val) {
    _addRemoveLikeLoading = val;
    notifyListeners();
  }

  Future<void> addReelsRemoveLikeApi(dynamic token, int reelIndex,
      Map<String, dynamic> data, int reelsId, BuildContext context) async {
    addReelsRemoveLikesLoading(true);
    myRepo.addReelsRemoveLikesApi(token, data, reelsId).then((value) {
      addReelsRemoveLikesLoading(false);
      //Utils.tostMessage('${value['message']}');
    }).onError((error, stackTrace) {
      addReelsRemoveLikesLoading(false);
      Utils.tostMessage('$error');
    });
  }
}
