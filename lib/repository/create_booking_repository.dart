import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class CreateBookingRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<dynamic> createBookingApi(
      String token, Map<String, String> data,) async {
    try {
      dynamic response = await apiAServices.postApiResponse(
          AppUrl.createBooking, token, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
