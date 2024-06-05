import 'package:airjood/model/fridge_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class FridgeRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<FridgeModel> getFridge(String token) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          AppUrl.getFridge, token);
      return response = FridgeModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
