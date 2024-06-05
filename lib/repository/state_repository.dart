import 'package:airjood/model/state_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class StateRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<StateModel> getState(String token,String countryId) async {
    try {
      dynamic response =
      await apiAServices.getGetApiResponse('${AppUrl.getState}?country_id=$countryId', token);
      return response = StateModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
