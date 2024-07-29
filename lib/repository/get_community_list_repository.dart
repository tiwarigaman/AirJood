import 'package:airjood/model/community_list_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class GetCommunityListRepository {
  BaseApiAServices apiAServices = NetworkApiService();
  Future<CommunityListModel> getCommunityList(String token,String search) async {
    try {
      dynamic response =
      await apiAServices.getGetApiResponse('${AppUrl.getCommunity}${search.isNotEmpty ? '?search=$search' : ''}', token);
      return response = CommunityListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
