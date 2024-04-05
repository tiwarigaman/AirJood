import 'dart:io';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class addReelRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> addReelsApi(
      String token, Map<String, String> data, File reel, File image) async {
    try {
      dynamic response = await apiAServices.reelPostApiResponse(
          AppUrl.addReels, token, data, reel, image);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
