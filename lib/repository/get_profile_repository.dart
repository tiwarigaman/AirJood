import 'package:airjood/model/profile_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class ProfileRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<ProfileModel> getProfile(String token,int userId) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          '${AppUrl.getProfile}/$userId', token);
      return response = ProfileModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
