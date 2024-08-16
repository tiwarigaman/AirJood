import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/invite_user_list_model.dart';
import '../model/search_model.dart';
import '../res/app_url.dart';

class SearchRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<SearchResultModel> getSearch(
      String token,
      String location,
      String date,
      String priceFrom,
      String priceTo,
      List<dynamic> mood,
      bool addons) async {
    try {
      String moodQuery = '';
      if (mood.isNotEmpty) {
        moodQuery = mood
            .map((moodItem) => '&mood[]=$moodItem')
            .reduce((value, element) => value + element);
      }
      dynamic response = await apiAServices.getSearchGetApiResponse(
          "${AppUrl.searchExperiance}${location.isEmpty ? '' : 'location=$location'}${date.isEmpty ? '' : '&date=$date'}${priceFrom.isEmpty ? '' : '&price_from=$priceFrom'}${priceTo.isEmpty ? '' : '&price_to=$priceTo'}${moodQuery ?? ''}&addons=$addons",
          token);
      return SearchResultModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<InviteUserListModel> getUserList(String token, int page,
      {String? search}) async {
    try {
      dynamic response = await apiAServices.getSearchGetApiResponse(
          "${AppUrl.getInviteUserList}?search=$search", token);
      return response = InviteUserListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
