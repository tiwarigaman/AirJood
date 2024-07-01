import 'package:airjood/repository/delete_ecperiance_repository.dart';
import 'package:airjood/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import 'get_experiance_list_view_model.dart';
import 'get_reels_view_model.dart';

class DeleteExperianceViewModel with ChangeNotifier {
  final myRepo = DeleteExperianceRepository();

  Future<void> deleteExperianceApi(
      String token, int id, BuildContext context,{bool? reels,int? userId}) async {
   if(reels == true){
     myRepo.deleteReels(token, id).then((value) {
       Utils.toastMessage('${value['message']}');
       UserViewModel().getToken().then((value) async {
         final deleteProvider =
         Provider.of<ReelsViewModel>(context, listen: false);
         deleteProvider.reelsUserGetApi(userId!, value!, 1);
       });
       Navigator.pop(context);
     }).onError((error, stackTrace) {
       Utils.toastMessage('$error');
     });
   }else {
     myRepo.deleteExperiance(token, id).then((value) {
       Utils.toastMessage('${value['message']}');
       UserViewModel().getToken().then((value) async {
         final experianceProvider =
         Provider.of<GetExperianceListViewModel>(context, listen: false);
         experianceProvider.getExperianceListApi(value!, 1);
       });
       Navigator.pop(context);
     }).onError((error, stackTrace) {
       Utils.toastMessage('$error');
     });
   }
  }
}
