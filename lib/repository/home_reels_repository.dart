import 'package:airjood/model/home_reels_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class HomeReelsRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<HomeReelsModel> getHomeReels(String token, int page) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          '${AppUrl.getHomeReels}?page=$page', token);
      return response = HomeReelsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
