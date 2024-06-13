import 'dart:io';
import 'package:airjood/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/add_experiance_repository.dart';
import '../utils/utils.dart';
import '../view/navigation_view/home_screens/sub_home_screens/experience_screens/upload_experience_details.dart';
import 'get_experiance_list_view_model.dart';

class AddExperianceViewModel with ChangeNotifier {
  final myRepo = AddExperianceRepository();

  bool _addExperianceLoading = false;

  bool get addExperianceLoadings => _addExperianceLoading;

  addExperianceLoading(bool val) {
    _addExperianceLoading = val;
    notifyListeners();
  }

  Future<void> addExperianceApi(String token, Map<String, String> data,
      File image, BuildContext context) async {
    addExperianceLoading(true);
    myRepo.addExperianceApi(token, data, image).then((value) {
      addExperianceLoading(false);
      Utils.toastMessage('${value['message']}');
      UserViewModel().getToken().then((value) async {
        final experianceProvider =
            Provider.of<GetExperianceListViewModel>(context, listen: false);
        await experianceProvider.getExperianceListApi(value!, 1);
      });
      Navigator.of(context, rootNavigator: true).pop(true);
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height * 0.90,
            width: MediaQuery.of(context).size.width),
        isScrollControlled: true,
        builder: (_) => UploadExperienceDetails(id: value['data']['id']),
      );
    }).onError((error, stackTrace) {
      addExperianceLoading(false);
      Utils.toastMessage('$error');
    });
  }
}
