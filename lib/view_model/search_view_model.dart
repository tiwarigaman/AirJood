import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../model/search_model.dart';
import '../repository/sesrch_repository.dart';
import '../utils/utils.dart';

class SearchViewModel with ChangeNotifier {
  final myRepo = SearchRepository();

  ApiResponse<SearchResultModel> searchData = ApiResponse.loading();
  setSearchList(ApiResponse<SearchResultModel> response) {
    searchData = response;
    notifyListeners();
  }

  Future<void> searchGetApi(String token, String location, String date,
      String priceFrom, String priceTo, List<dynamic> mood, bool addons) async {
    setSearchList(ApiResponse.loading());
    try {
      final value = await myRepo.getSearch(token, location, date, priceFrom, priceTo, mood, addons);
      setSearchList(ApiResponse.completed(value));
    } catch (error) {
      setSearchList(ApiResponse.error(error.toString()));
      Utils.toastMessage('$error');
    }
  }
}
