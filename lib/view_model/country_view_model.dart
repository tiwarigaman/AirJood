import 'package:airjood/model/country_model.dart';
import 'package:airjood/repository/country_repository.dart';
import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../utils/utils.dart';

class CountryViewModel with ChangeNotifier {
  final myRepo = CountryRepository();

  ApiResponse<CountryModel> countryData = ApiResponse.loading();
  setCountryList(ApiResponse<CountryModel> response) {
    countryData = response;
    notifyListeners();
  }

  Future<void> countryGetApi(String token) async {
    setCountryList(ApiResponse.loading());
    myRepo.getCountry(token).then((value) {
      setCountryList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCountryList(ApiResponse.error(error.toString()));
      Utils.tostMessage('$error');
    });
  }
}
