import 'dart:io';

import 'package:airjood/repository/upgrade_user_repository.dart';
import 'package:flutter/cupertino.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class UpdateUserModel with ChangeNotifier {
  final myRepo = UpdateUserRepository();

  bool _updateUserLoading = false;

  bool get updateUserLoading => _updateUserLoading;

  updateUserPremiumLoading(bool val) {
    _updateUserLoading = val;
    notifyListeners();
  }

  Future<void> updateUserApi(String token, File? image, File? image1,
      File? image2, File? image3, BuildContext context) async {
    updateUserPremiumLoading(true);
    print('Toke => $token');
    print('Image1 => $image');
    print('Image2 => $image1');
    print('Image3 => $image2');
    print('Image4 => $image3');
    myRepo.updateUserApi(token, image, image1, image2, image3).then((value) {
      updateUserPremiumLoading(false);
      Utils.toastMessage('${value['message']}');
      Navigator.pushNamed(context, RoutesName.navigation);
    }).onError((error, stackTrace) {
      updateUserPremiumLoading(false);
      Utils.toastMessage('$error');
    });
  }
}
