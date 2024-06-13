import 'package:airjood/utils/routes/routes.dart';
import 'package:airjood/utils/routes/routes_name.dart';
import 'package:airjood/view_model/accept_reject_invitation_view_model.dart';
import 'package:airjood/view_model/add_comment_view_model.dart';
import 'package:airjood/view_model/add_experiance_view_model.dart';
import 'package:airjood/view_model/add_invitation_view_model.dart';
import 'package:airjood/view_model/add_planning_view_model.dart';
import 'package:airjood/view_model/add_reels_planning_view_model.dart';
import 'package:airjood/view_model/add_reels_view_model.dart';
import 'package:airjood/view_model/add_remove_like_view_model.dart';
import 'package:airjood/view_model/auth_view_model.dart';
import 'package:airjood/view_model/chat_view_model.dart';
import 'package:airjood/view_model/comment_view_model.dart';
import 'package:airjood/view_model/country_view_model.dart';
import 'package:airjood/view_model/create_booking_view_model.dart';
import 'package:airjood/view_model/delete_experiance_view_model.dart';
import 'package:airjood/view_model/delete_follower_view_model.dart';
import 'package:airjood/view_model/delete_notification_view_model.dart';
import 'package:airjood/view_model/delete_planning_reels_view_model.dart';
import 'package:airjood/view_model/facilities_view_model.dart';
import 'package:airjood/view_model/follow_view_model.dart';
import 'package:airjood/view_model/followers_view_model.dart';
import 'package:airjood/view_model/following_view_model.dart';
import 'package:airjood/view_model/get_booking_list_view_model.dart';
import 'package:airjood/view_model/get_experiance_list_view_model.dart';
import 'package:airjood/view_model/get_fridge_view_model.dart';
import 'package:airjood/view_model/get_planning_list_view_model.dart';
import 'package:airjood/view_model/get_reels_view_model.dart';
import 'package:airjood/view_model/get_user_profile_view_model.dart';
import 'package:airjood/view_model/home_reels_view_model.dart';
import 'package:airjood/view_model/invite_user_list_view_model.dart';
import 'package:airjood/view_model/logout_view_model.dart';
import 'package:airjood/view_model/mood_view_model.dart';
import 'package:airjood/view_model/music_view_model.dart';
import 'package:airjood/view_model/notification_list_view_model.dart';
import 'package:airjood/view_model/planning_details_view_model.dart';
import 'package:airjood/view_model/read_unread_notification_view_model.dart';
import 'package:airjood/view_model/search_view_model.dart';
import 'package:airjood/view_model/share_reels_get_view_model.dart';
import 'package:airjood/view_model/state_view_model.dart';
import 'package:airjood/view_model/update_user_view_model.dart';
import 'package:airjood/view_model/upload_experiance_view_model.dart';
import 'package:airjood/view_model/user_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = "pk_test_Pyu4oj7fU3CFtbcP0gH16Ila";
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    notification();
    super.initState();
  }

  Future<void> notification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/union');
    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse response) async {},
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ''),
        content: Text(body ?? ''),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
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
        ChangeNotifierProvider(create: (context) => FollowingViewModel()),
        ChangeNotifierProvider(create: (context) => FollowersViewModel()),
        ChangeNotifierProvider(create: (context) => FollowViewModel()),
        ChangeNotifierProvider(create: (context) => DeleteFollowerViewModel()),
        ChangeNotifierProvider(create: (context) => GetBookingListViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => CreateBookingViewModel()),
        ChangeNotifierProvider(create: (context) => AddPlanningViewModel()),
        ChangeNotifierProvider(create: (context) => GetPlanningListViewModel()),
        ChangeNotifierProvider(create: (context) => CountryViewModel()),
        ChangeNotifierProvider(create: (context) => StateViewModel()),
        ChangeNotifierProvider(create: (context) => PlanningDetailsViewModel()),
        ChangeNotifierProvider(
            create: (context) => AddReelsPlanningViewModel()),
        ChangeNotifierProvider(create: (context) => InviteUserListViewModel()),
        ChangeNotifierProvider(
            create: (context) => AcceptRejectInvitationViewModel()),
        ChangeNotifierProvider(
            create: (context) => NotificationListViewModel()),
        ChangeNotifierProvider(
            create: (context) => DeleteNotificationViewModel()),
        ChangeNotifierProvider(create: (context) => AddInvitationViewModel()),
        ChangeNotifierProvider(create: (context) => FridgeViewModel()),
        ChangeNotifierProvider(
            create: (context) => DeletePlanningReelsViewModel()),
        ChangeNotifierProvider(create: (context) => LogoutViewModel()),
        ChangeNotifierProvider(create: (context) => ChatViewModel()),
        ChangeNotifierProvider(create: (context) => ReadNotificationViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            background: Colors.white,
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
