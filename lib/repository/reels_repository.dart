// reels_repository

import 'package:airjood/model/reels_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class ReelsRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<ReelsModel> getReels(String token, int page) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          '${AppUrl.getReels}?page=$page', token);
      return response = ReelsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ReelsModel> getUserReels(int userId, String token, int page) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          '${AppUrl.getReels}/$userId?page=$page', token);
      return response = ReelsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
