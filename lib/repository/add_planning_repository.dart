import 'dart:io';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class AddPlanningRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> addPlanningApi(
      String token, Map<String, String> data, File image,
      {bool? edit, int? planId}) async {
    try {
      if (edit == false) {
        dynamic response = await apiAServices.planningPostApiResponse(
            AppUrl.addPlanning, token, data, image);
        return response;
      } else {
        dynamic response = await apiAServices.planningPostApiResponse(
            '${AppUrl.editPlanning}/$planId', token, data, image);
        return response;
      }
    } catch (e) {
      rethrow;
    }
  }
}
