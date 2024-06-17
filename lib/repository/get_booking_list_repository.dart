import 'package:airjood/model/booking_list_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class GetBookingListRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<BookingListModel> getBookingList(String token, {int? userId}) async {
    try {
      dynamic response =
          await apiAServices.getGetApiResponse(AppUrl.getBookingList, token);
      // response['data'].forEach((element) {
      //   var user = element['experience']['user'];
      //   element['user'] = user;
      // });
      return response = BookingListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BookingListModel> getBookingListUser(String token,
      {int? userId}) async {
    try {
      if(userId == null){
        dynamic response = await apiAServices.getGetApiResponse(
            AppUrl.getBookingListUser, token);
        return response = BookingListModel.fromJson(response);
      }else{
        dynamic response = await apiAServices.getGetApiResponse(
            AppUrl.getBookingListUser, token);
        return response = BookingListModel.fromJson(response);
      }

    } catch (e) {
      rethrow;
    }
  }
}
