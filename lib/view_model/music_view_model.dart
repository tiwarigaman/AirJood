import 'package:airjood/model/music_model.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../repository/music_repository.dart';
import '../utils/utils.dart';

class MusicViewModel with ChangeNotifier {
  final myRepo = MusicRepository();

  ApiResponse<MusicModel> musicData = ApiResponse.loading();
  setMusicList(ApiResponse<MusicModel> response) {
    musicData = response;
    notifyListeners();
  }

  Future<void> musicGetApi(String token) async {
    setMusicList(ApiResponse.loading());
    myRepo.getMusic(token).then((value) {
      setMusicList(ApiResponse.completed(value));
      //Utils.tostMessage('$value');
    }).onError((error, stackTrace) {
      setMusicList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
