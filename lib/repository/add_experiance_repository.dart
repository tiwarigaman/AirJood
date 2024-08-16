import 'dart:io';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class AddExperianceRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> addExperianceApi(
      String token, Map<String, dynamic> data, File image) async {
    try {
      dynamic response = await apiAServices.experiancePostApiResponse(
          AppUrl.addExperiance, token, data, image);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
