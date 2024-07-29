import 'package:airjood/model/community_details_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class GetCommunityDetailsRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<CommunityDetailsModel> getCommunityDetails(String token, int id) async {
    try {
      dynamic response = await apiAServices.getGetApiResponse(
          '${AppUrl.getCommunityDetails}/$id', token);
      return response = CommunityDetailsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
