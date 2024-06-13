import 'dart:io';
import 'package:airjood/repository/create_booking_repository.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class CreateBookingViewModel with ChangeNotifier {
  final myRepo = CreateBookingRepository();

  bool _createBookingLoading = false;

  bool get createBookingLoadings => _createBookingLoading;

  createBookingLoading(bool val) {
    _createBookingLoading = val;
    notifyListeners();
  }

  Future<void> createBookingApi(
      String token, Map<String, dynamic> data, BuildContext context) async {
    createBookingLoading(true);
    await myRepo.createBookingApi(token, data).then((value) {
      createBookingLoading(false);
      Utils.toastMessage('${value['message']}');
      Navigator.of(context, rootNavigator: true).pop(true);
    }).onError((error, stackTrace) {
      createBookingLoading(false);
      Utils.toastMessage('$error');
    });
  }
}
