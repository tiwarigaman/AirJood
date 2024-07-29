import 'package:airjood/model/contactus_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class GetContactUsRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<ContactUsModel> getCommunityDetails(String token) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          AppUrl.getContactUS, token);
      return response = ContactUsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
