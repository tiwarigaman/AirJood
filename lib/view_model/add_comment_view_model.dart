import 'package:airjood/view_model/user_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../repository/add_comment_repository.dart';
import '../utils/utils.dart';
import 'comment_view_model.dart';

class AddCommentViewModel extends ChangeNotifier {
  final myRepo = AddCommentRepository();
  bool _addCommentLoading = false;

  bool get addCommentLoading => _addCommentLoading;

  addCommentsLoading(bool val) {
    _addCommentLoading = val;
    notifyListeners();
  }

  Future<void> addCommentsApi(dynamic token, Map<String, String> data,
      BuildContext context, int reelsId, Function() callback) async {
    addCommentsLoading(true);
    myRepo.addCommentApi(token, data).then((value) {
      addCommentsLoading(false);
      UserViewModel().getToken().then((value) {
        Provider.of<CommentViewModel>(context, listen: false)
            .commentGetApi(value!, reelsId);
      }).then((value) {
        callback();
      });
      Utils.tostMessage('${value['message']}');
    }).onError((error, stackTrace) {
      addCommentsLoading(false);
      Utils.tostMessage('$error');
    });
  }
}
