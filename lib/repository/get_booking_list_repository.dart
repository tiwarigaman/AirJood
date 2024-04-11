import 'package:airjood/model/booking_list_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class GetBookingListRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<BookingListModel> getBookingList(String token) async {
    try {
      dynamic response =
          await apiAServices.getGetApiResponse(AppUrl.getBookingList, token);
      return response = BookingListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Future<GetExperienceModel> getReelsUserExperianceList(
  //     int userId, String token, int page) async {
  //   try {
  //     dynamic response = await apiAServices.getGetApiResponse(
  //         '${AppUrl.getExperianceList}?page=$page&&user=$userId', token);
  //     return response = GetExperienceModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
