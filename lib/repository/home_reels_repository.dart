import 'package:airjood/model/home_reels_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class HomeReelsRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<HomeReelsModel> getHomeReels(String token, int page,
      {int? tabIndex}) async {
    try {
      if (tabIndex == 1) {
        dynamic response = await apiAServices.getGetApiResponse(
            '${AppUrl.getHomeReels}?page=$page/?is_following=1', token);
        return response = HomeReelsModel.fromJson(response);
      } else {
        dynamic response = await apiAServices.getGetApiResponse(
            '${AppUrl.getHomeReels}?page=$page', token);
        return response = HomeReelsModel.fromJson(response);
      }
    } catch (e) {
      rethrow;
    }
  }
}