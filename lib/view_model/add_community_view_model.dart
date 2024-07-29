import 'dart:io';
import 'package:airjood/repository/add_community_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import 'get_community_list_view_model.dart';

class AddCommunityViewModel with ChangeNotifier {
  final myRepo = AddCommunityRepository();

  bool _addCommunityLoading = false;

  bool get addCommunityLoadings => _addCommunityLoading;

  addCommunityLoading(bool val) {
    _addCommunityLoading = val;
    notifyListeners();
  }

  Future<void> addCommunityApi(String token, Map<String, String> data,
      File coverImage, File profileImage, BuildContext context) async {
    addCommunityLoading(true);
    myRepo.addCommunityApi(token, data, coverImage, profileImage).then((value) {
      addCommunityLoading(false);
      if(value != null){
        Provider.of<GetCommunityListViewModel>(context, listen: false)
            .communityListGetApi(token, '');
      }
      Navigator.pop(context);
      Utils.toastMessage('${value['message']}');
    }).onError((error, stackTrace) {
      addCommunityLoading(false);
      Utils.toastMessage('$error');
    });
  }
}
