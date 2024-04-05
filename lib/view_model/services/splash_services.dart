import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/user_view_model.dart';

class SplashServices {
  Future<String?> getUserToken() => UserViewModel().getToken();

  void checkAuthentication(context) async {
    getUserToken().then(
      (value) async {
        print(value);
        if (value == null) {
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pushNamed(context, RoutesName.onboarding);
        } else if (value == 'null' || value == '') {
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pushNamed(context, RoutesName.onboarding);
        } else {
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pushNamed(context, RoutesName.navigation);
        }
      },
    ).onError(
      (error, stackTrace) {
        if (kDebugMode) {
          print(error);
        }
      },
    );
  }
}
