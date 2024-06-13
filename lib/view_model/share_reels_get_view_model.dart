import 'package:airjood/model/share_reels_get_model.dart';
import 'package:airjood/repository/share_reels_get_repositoty.dart';
import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../utils/utils.dart';

class ShareReelsGetViewModel with ChangeNotifier {
  final myRepo = ShareReelsGetRepository();

  ApiResponse<ShareReelsGetModel> getShareReelsData = ApiResponse.loading();
  setGetShareReelsData(ApiResponse<ShareReelsGetModel> response) {
    getShareReelsData = response;
    notifyListeners();
  }

  Future<void> getShareReelsApi(String token, String id) async {
    setGetShareReelsData(ApiResponse.loading());
    await myRepo.getShareReels(token, id).then((value) {
      setGetShareReelsData(ApiResponse.completed(value));
      //Utils.tostMessage('$value');
    }).onError((error, stackTrace) {
      setGetShareReelsData(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
