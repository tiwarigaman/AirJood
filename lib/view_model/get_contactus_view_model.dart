import 'package:airjood/model/contactus_model.dart';
import 'package:airjood/repository/get_contactus_repository.dart';
import 'package:flutter/cupertino.dart';
import '../data/response/api_response.dart';
import '../utils/utils.dart';

class GetContactUsViewModel with ChangeNotifier {
  final myRepo = GetContactUsRepository();

  ApiResponse<ContactUsModel> getContactUsData = ApiResponse.loading();
  setGetContactUs(ApiResponse<ContactUsModel> response) {
    getContactUsData = response;
    notifyListeners();
  }

  Future<void> getContactUsApi(String token) async {
    setGetContactUs(ApiResponse.loading());
    await myRepo.getCommunityDetails(token).then((value) {
      setGetContactUs(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setGetContactUs(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    });
  }
}
