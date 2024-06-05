import 'package:airjood/model/booking_list_model.dart';
import 'package:airjood/repository/get_booking_list_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';

class GetBookingListViewModel with ChangeNotifier {
  final myRepo = GetBookingListRepository();

  final List<BookingData> _data3 = [];

  List<BookingData> get data3 => _data3;

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

  Future<void> getBookingListApi(String token,{int? userId}) async {
    setGetBookingList(ApiResponse.loading());
    await myRepo.getBookingList(token,userId: userId).then((value) {
      setGetBookingList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
  Future<void> getBookingListApiUser(String token,{int? userId}) async {
    setGetBookingList(ApiResponse.loading());
    await myRepo.getBookingListUser(token,userId: userId).then((value) {
      setGetBookingList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

}
