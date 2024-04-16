import 'package:airjood/model/booking_list_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class GetBookingListRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<BookingListModel> getBookingList(String token, {int? userId}) async {
    try {
      if (userId != null) {
        print('userId $userId');
        dynamic response =
            await apiAServices.getGetApiResponse('${AppUrl.getBookingList}/$userId', token);
        return response = BookingListModel.fromJson(response);
      } else {
        dynamic response =
            await apiAServices.getGetApiResponse(AppUrl.getBookingList, token);
        return response = BookingListModel.fromJson(response);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
