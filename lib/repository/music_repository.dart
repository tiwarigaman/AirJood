import 'package:airjood/model/music_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class MusicRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<MusicModel> getMusic(String token) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          '${AppUrl.getAudio}?page=${1}', token);
      return response = MusicModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
