import 'dart:io';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class UpdateUserRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<dynamic> updateUserApi(
    String? token,
    File? image,
    File? image1,
    File? image2,
    File? image3,
  ) async {
    try {
      dynamic response = await apiAServices.documentPostApiResponse(
          AppUrl.upgradeProfile, token, image, image1, image2, image3);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
