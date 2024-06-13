import 'package:airjood/repository/follow_repository.dart';
import 'package:airjood/repository/logout_repository.dart';
import 'package:airjood/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import '../view/auth_view/login_screen.dart';

class LogoutViewModel extends ChangeNotifier {
  final myRepo = LogoutRepository();
  bool _logoutLoading = false;

  bool get logoutLoading => _logoutLoading;

  logoutLoadings(bool val) {
    _logoutLoading = val;
    notifyListeners();
  }

  Future<void> logoutApi(dynamic token, BuildContext context) async {
    logoutLoadings(true);
    myRepo.logoutApi(token).then((val) {
      final userData = Provider.of<UserViewModel>(context,listen: false);
      userData.remove().then(
        (value) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        },
      );
      userData.removeUser();
      userData.remove();
      userData.removeDeviceToken();
      logoutLoadings(false);
    }).onError((error, stackTrace) {
      logoutLoadings(false);
      Utils.toastMessage('$error');
    });
  }
}
