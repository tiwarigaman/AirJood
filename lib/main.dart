import 'package:airjood/res/components/color.dart';
import 'package:airjood/utils/routes/routes.dart';
import 'package:airjood/utils/routes/routes_name.dart';
import 'package:airjood/view_model/add_comment_view_model.dart';
import 'package:airjood/view_model/add_experiance_view_model.dart';
import 'package:airjood/view_model/add_reels_view_model.dart';
import 'package:airjood/view_model/add_remove_like_view_model.dart';
import 'package:airjood/view_model/auth_view_model.dart';
import 'package:airjood/view_model/comment_view_model.dart';
import 'package:airjood/view_model/delete_experiance_view_model.dart';
import 'package:airjood/view_model/facilities_view_model.dart';
import 'package:airjood/view_model/followers_view_model.dart';
import 'package:airjood/view_model/get_experiance_list_view_model.dart';
import 'package:airjood/view_model/get_reels_view_model.dart';
import 'package:airjood/view_model/home_reels_view_model.dart';
import 'package:airjood/view_model/mood_view_model.dart';
import 'package:airjood/view_model/music_view_model.dart';
import 'package:airjood/view_model/search_view_model.dart';
import 'package:airjood/view_model/share_reels_get_view_model.dart';
import 'package:airjood/view_model/update_user_view_model.dart';
import 'package:airjood/view_model/upload_experiance_view_model.dart';
import 'package:airjood/view_model/user_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.mainColor,
        statusBarIconBrightness: Brightness.light));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => MusicViewModel()),
        ChangeNotifierProvider(create: (context) => UpdateUserModel()),
        ChangeNotifierProvider(create: (context) => AddReelViewModel()),
        ChangeNotifierProvider(create: (context) => ReelsViewModel()),
        ChangeNotifierProvider(create: (context) => MoodViewModel()),
        ChangeNotifierProvider(create: (context) => FacilitiesViewModel()),
        ChangeNotifierProvider(create: (context) => SearchViewModel()),
        ChangeNotifierProvider(create: (context) => CommentViewModel()),
        ChangeNotifierProvider(create: (context) => AddCommentViewModel()),
        ChangeNotifierProvider(create: (context) => AddRemoveLikeViewModel()),
        ChangeNotifierProvider(create: (context) => HomeReelsViewModel()),
        ChangeNotifierProvider(create: (context) => ShareReelsGetViewModel()),
        ChangeNotifierProvider(
            create: (context) => DeleteExperianceViewModel()),
        ChangeNotifierProvider(
            create: (context) => UploadExperianceViewModel()),
        ChangeNotifierProvider(
            create: (context) => GetExperianceListViewModel()),
        ChangeNotifierProvider(create: (context) => AddExperianceViewModel()),
        ChangeNotifierProvider(create: (context) => FollowersViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              background: Colors.white,
              seedColor: Colors.blue,
              brightness: Brightness.light),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
