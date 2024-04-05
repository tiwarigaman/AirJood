import 'package:airjood/utils/routes/routes_name.dart';
import 'package:airjood/view/auth_view/login_screen.dart';
import 'package:airjood/view/auth_view/verify_code_screen.dart';
import 'package:airjood/view/navigation_view/add_new_reels/sub_view/preview_reels_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/followers_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/edit_profile_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/setting_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/upgrade_as_guide_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/user_details_screen.dart';
import 'package:airjood/view/navigation_view/navigationbar.dart';
import 'package:airjood/view/onbording_view/onboarding_screen.dart';
import 'package:airjood/view/splash_view/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../view/auth_view/register_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // print(settings.arguments);
    // print(settings.name);

    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RoutesName.onboarding:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RoutesName.verify:
        Map<String, String>? val = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          builder: (context) => VerifyCodeScreen(
            mobile: val?['mobile'],
            otp: val?['OTP'],
          ),
        );
      case RoutesName.register:
        Map<String, String>? val = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(
            mobile: val?['mobile'],
          ),
        );
      case RoutesName.navigation:
        return MaterialPageRoute(
          builder: (context) => const CustomNavigationBar(),
        );
      case RoutesName.userDetail:
        return MaterialPageRoute(
          builder: (context) => const UserDetailsScreen(),
        );
      case RoutesName.editProfile:
        Map<String, dynamic>? val = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => EditProfileScreen(
            number: val?['number'],
            token: val?['token'],
            image: val?['image'],
            name: val?['name'],
            email: val?['email'],
            gender: val?['gender'],
            dob: val?['dob'],
            language: val?['language'],
            about: val?['about'],
          ),
        );
      case RoutesName.setting:
        return MaterialPageRoute(
          builder: (context) => const SettingScreen(),
        );
      case RoutesName.upgradeGuide:
        return MaterialPageRoute(
          builder: (context) => const UpgradeGuideScreen(),
        );
      case RoutesName.previewReelsScreen:
        return MaterialPageRoute(
          builder: (context) => const PreviewReelsScreen(),
        );
      case RoutesName.followersScreen:
        return MaterialPageRoute(
          builder: (context) => const FollowersScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
    }
  }
}
