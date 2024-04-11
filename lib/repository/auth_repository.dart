import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class AuthRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<dynamic> login(Map<String, String> data) async {
    try {
      dynamic response =
          await apiAServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> OTPSendApi(Map<String, String> data) async {
    try {
      dynamic response =
          await apiAServices.otpPostApiResponse(AppUrl.verifyCode, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> RegisterApi(Map<String, String> data) async {
    try {
      dynamic response =
          await apiAServices.getPostApiResponse(AppUrl.register, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> updateProfileApi(
      dynamic token, Map<String, String> data, dynamic image) async {
    try {
      dynamic response = await apiAServices.profilePostApiResponse(
          AppUrl.profile, token, data, image);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
