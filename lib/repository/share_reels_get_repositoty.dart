import 'package:airjood/model/share_reels_get_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class ShareReelsGetRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<ShareReelsGetModel> getShareReels(String token, String id) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          '${AppUrl.getShareReels}/$id', token);
      return response = ShareReelsGetModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
