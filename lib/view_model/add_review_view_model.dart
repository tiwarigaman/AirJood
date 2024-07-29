import 'package:airjood/repository/add_review_repository.dart';
import 'package:flutter/widgets.dart';
import '../utils/utils.dart';

class AddReviewViewModel extends ChangeNotifier {
  final myRepo = AddReviewRepository();
  bool _addReviewLoading = false;

  bool get addReviewsLoading => _addReviewLoading;

  addReviewLoading(bool val) {
    _addReviewLoading = val;
    notifyListeners();
  }

  Future<void> addReviewApi(String token, Map<String, String> data,
      BuildContext context) async {
    addReviewLoading(true);
    myRepo.addReviewApi(token, data).then((value) {
      addReviewLoading(false);
      Navigator.pop(context);
      Utils.toastMessage('${value['message']}');
    }).onError((error, stackTrace) {
      addReviewLoading(false);
      Utils.toastMessage('$error');
    });
  }
}
