import 'package:airjood/repository/delete_ecperiance_repository.dart';
import 'package:airjood/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import 'get_experiance_list_view_model.dart';

class DeleteExperianceViewModel with ChangeNotifier {
  final myRepo = DeleteExperianceRepository();

  Future<void> deleteExperianceApi(
      String token, int id, BuildContext context) async {
    myRepo.deleteExperiance(token, id).then((value) {
      Utils.toastMessage('${value['message']}');
      UserViewModel().getToken().then((value) async {
        final experianceProvider =
            Provider.of<GetExperianceListViewModel>(context, listen: false);
        experianceProvider.getExperianceListApi(value!, 1);
      });
      Navigator.pop(context);
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => const CustomNavigationBar()),
      //   (route) => false,
      // );
    }).onError((error, stackTrace) {
      Utils.toastMessage('$error');
    });
  }
}
