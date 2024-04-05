import 'dart:io';

import 'package:airjood/repository/add_reel_repository.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../view/navigation_view/navigationbar.dart';

class AddReelViewModel with ChangeNotifier {
  final myRepo = addReelRepository();

  bool _addReelLoading = false;

  bool get addReelsLoading => _addReelLoading;

  addReelLoading(bool val) {
    _addReelLoading = val;
    notifyListeners();
  }

  Future<void> addReelApi(String screen, String token, Map<String, String> data,
      File reel, File image, BuildContext context) async {
    addReelLoading(true);
    myRepo.addReelsApi(token, data, reel, image).then((value) {
      addReelLoading(false);
      Utils.tostMessage('${value['message']}');
      if (screen == 'Laqta') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const CustomNavigationBar()),
          (route) => false,
        );
      } else {
        Navigator.pop(context, {
          'id': value['data']['id'],
          'video_url': value['data']['video_url'],
          'video_thumbnail_url': value['data']['video_thumbnail_url']
        });
        Navigator.pop(context, {
          'id': value['data']['id'],
          'video_url': value['data']['video_url'],
          'video_thumbnail_url': value['data']['video_thumbnail_url']
        });
      }
    }).onError((error, stackTrace) {
      addReelLoading(false);
      Utils.tostMessage('$error');
    });
  }
}
