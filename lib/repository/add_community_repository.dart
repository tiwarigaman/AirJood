import 'dart:io';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class AddCommunityRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> addCommunityApi(
      String token, Map<String, String> data, File coverImage, File profileImage,) async {
    try {
      dynamic response = await apiAServices.communityPostApiResponse(
          AppUrl.addCommunity, token, data, coverImage,profileImage);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
