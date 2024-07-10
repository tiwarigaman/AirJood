import 'package:airjood/model/mood_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class MoodRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<MoodModel> getMood(String token) async {
    try {
      dynamic response =
          await apiAServices.getGetApiResponse(AppUrl.getMood, token);
      return response = MoodModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
