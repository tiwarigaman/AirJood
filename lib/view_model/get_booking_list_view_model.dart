import 'package:airjood/model/booking_list_model.dart';
import 'package:airjood/repository/get_booking_list_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../utils/utils.dart';

class GetBookingListViewModel with ChangeNotifier {
  final myRepo = GetBookingListRepository();

  final List<Data> _data3 = [];

  List<Data> get data3 => _data3;

  ApiResponse<BookingListModel> getBookingData = ApiResponse.loading();

  setGetBookingList(ApiResponse<BookingListModel> response) {
    getBookingData = response;
    _data3.clear();
    if (response.data != null) {
      for (var element in response.data!.data!) {
        _data3.add(element);
      }
    }
    notifyListeners();
  }

  Future<void> getBookingListApi(String token) async {
    setGetBookingList(ApiResponse.loading());
    await myRepo.getBookingList(token).then((value) {
      setGetBookingList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setGetBookingList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }

  // Future<void> getReelsUserExperianceListApi(
  //     int userId, String token, int page) async {
  //   setGetExperianceList(ApiResponse.loading());
  //   await myRepo.getReelsUserExperianceList(userId, token, page).then((value) {
  //     setGetExperianceList(ApiResponse.completed(value));
  //     //Utils.tostMessage('$value');
  //   }).onError((error, stackTrace) {
  //     setGetExperianceList(ApiResponse.error(error.toString()));
  //     Utils.tostMessage('$error');
  //   });
  // }
}
