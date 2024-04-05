import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/search_model.dart';
import '../res/app_url.dart';

class SearchRepository {
  BaseApiAServices apiAServices = NetworkApiService();

  Future<SearchResultModel> getSearch(String token, String location,
      String date, String price, List<dynamic> mood, bool addons) async {
    try {
      String moodQuery = '';
      if (mood.isNotEmpty) {
        moodQuery = mood
            .map((moodItem) => '&mood[]=$moodItem')
            .reduce((value, element) => value + element);
        //moodQuery = '&mood[]=$mood';
      }
      dynamic response = await apiAServices.getSearchGetApiResponse(
          "${AppUrl.searchExperiance}${location.isEmpty ? '' : 'location=$location'}${date.isEmpty ? '' : '&date=$date'}${price.isEmpty ? '' : '&price=$price'}${moodQuery ?? ''}&addons=$addons",
          token);
      return SearchResultModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
