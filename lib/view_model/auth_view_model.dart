import 'package:airjood/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/auth_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final myRepo = AuthRepository();

  bool _mobileSendLoading = false;

  bool get mobileLoading => _mobileSendLoading;

  mobileSendLoading(bool val) {
    _mobileSendLoading = val;
    notifyListeners();
  }

  Future<void> mobileSendApi(
      String mobile, Map<String, String> data, BuildContext context) async {
    mobileSendLoading(true);
    myRepo.login(data).then((value) {
      mobileSendLoading(false);
      Utils.toastMessage('${value['message']}');
      Navigator.pushNamed(context, RoutesName.verify,
          arguments: {'mobile': mobile, "OTP": '${value['otp']}'});
    }).onError((error, stackTrace) {
      mobileSendLoading(false);
      Utils.toastMessage('$error');
    });
  }

  bool _otpLoading = false;

  bool get otpLoading_ => _otpLoading;

  otpLoading(bool val) {
    _otpLoading = val;
    notifyListeners();
  }

  Future<void> OTPVerifyApi(
      String mobile, Map<String, String> data, BuildContext context) async {
    otpLoading(true);
    myRepo.OTPSendApi(data).then((value) {
      otpLoading(false);
      Utils.toastMessage('${value['message']}');
      if (value['data']['token'] != null) {
        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        userPreference.saveToken(value['data']['token']);
        userPreference.saveUser(value['data']['user']);
        Navigator.pushNamed(context, RoutesName.navigation);
      } else {
        Navigator.pushNamed(context, RoutesName.register, arguments: {
          'mobile': mobile,
        });
      }
    }).onError((error, stackTrace) {
      otpLoading(false);
      Utils.toastMessage('$error');
    });
  }

  bool _RegisterLoading = false;

  bool get RegisterLoading => _RegisterLoading;

  registerLoading(bool val) {
    _RegisterLoading = val;
    notifyListeners();
  }

  Future<void> registerApi(
      Map<String, String> data, BuildContext context) async {
    registerLoading(true);
    myRepo.RegisterApi(data).then((value) {
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveToken(value['data']['token']);
      userPreference.saveUser(value['data']['user']);
      registerLoading(false);
      Utils.toastMessage('${value['message']}');
      Navigator.pushNamed(context, RoutesName.navigation);
    }).onError((error, stackTrace) {
      registerLoading(false);
      Utils.toastMessage('$error');
    });
  }

  bool _updateProfileLoading = false;

  bool get updateLoading => _updateProfileLoading;

  updateProfileLoading(bool val) {
    _updateProfileLoading = val;
    notifyListeners();
  }

  Future<void> updateProfileApi(dynamic token, Map<String, String> data,
      dynamic image, BuildContext context) async {
    updateProfileLoading(true);
    myRepo.updateProfileApi(token, data, image).then((value) {
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(value['data']);
      updateProfileLoading(false);
      Utils.toastMessage('${value['message']}');
      //Navigator.pushNamed(context, RoutesName.userDetail);
      Navigator.pop(context);
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => const UserDetailsScreen()),
      //   (route) => false,
      // );
    }).onError((error, stackTrace) {
      updateProfileLoading(false);
      Utils.toastMessage('$error');
      print(error);
    });
  }
}
