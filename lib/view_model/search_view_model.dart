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
      String price, List<dynamic> mood, bool addons) async {
    setSearchList(ApiResponse.loading());
    myRepo.getSearch(token, location, date, price, mood, addons).then((value) {
      setSearchList(ApiResponse.completed(value));
      //Utils.tostMessage(value.data.toString());
    }).onError((error, stackTrace) {
      setSearchList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
