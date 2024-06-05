// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:ui';

import 'package:airjood/view/navigation_view/community_view/community_screen.dart';
import 'package:airjood/view/navigation_view/planning_view/planning_screen.dart';
import 'package:airjood/view_model/share_reels_get_view_model.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../res/components/color.dart';
import '../../view_model/user_view_model.dart';
import 'ExitBar.dart';
import 'add_new_reels/reels_screen.dart';
import 'chat_view/chat_screen.dart';
import 'home_screens/home_screen.dart';
import 'home_screens/screen_widget/video_player.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  //final PageController _pageController = PageController();
  final List<Widget> _screens = [
    const HomeScreen(),
    const CommunityScreen(),
    const ReelsScreen(),
    const PlanningScreen(),
    const ChatScreen(),
  ];

  void _setPage(int pageIndex) {
    setState(() {
      _selectedIndex = pageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDynamicLink();
  }

  Future<void> fetchDynamicLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      List<String> separatedString = [];
      separatedString.addAll(deepLink.path.split('/'));
      fetchExperianceData(separatedString[2]);
    }

    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) {
        final Uri deepLink = pendingDynamicLinkData.link;
        List<String> separatedString = [];
        separatedString.addAll(deepLink.path.split('/'));
        fetchExperianceData(separatedString[2]);
      },
    );
  }

  Future<void> fetchExperianceData(String id) async {
    UserViewModel().getToken().then((value) async {
      final experianceProvider =
          Provider.of<ShareReelsGetViewModel>(context, listen: false);
      await experianceProvider.getShareReelsApi(value!, id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerWidget(
            videoUrl: '${experianceProvider.getShareReelsData.data?.videoUrl}',
            commentCount:
                experianceProvider.getShareReelsData.data?.commentCount,
            about: experianceProvider.getShareReelsData.data?.user?[0].about,
            dateTime:
                experianceProvider.getShareReelsData.data?.user?[0].createdAt,
            userId: experianceProvider.getShareReelsData.data?.user?[0].id,
            email: experianceProvider.getShareReelsData.data?.user?[0].email,
            guide:
                experianceProvider.getShareReelsData.data?.user?[0].isUpgrade,
            number:
                experianceProvider.getShareReelsData.data?.user?[0].contactNo,
            createdAt:
                experianceProvider.getShareReelsData.data?.user?[0].createdAt,
            image: experianceProvider
                .getShareReelsData.data?.user?[0].profileImageUrl,
            name: experianceProvider.getShareReelsData.data?.user?[0].name,
            description: experianceProvider.getShareReelsData.data?.caption,
            language:
                experianceProvider.getShareReelsData.data?.user?[0].languages,
            index: 1,
            likeCount: experianceProvider.getShareReelsData.data?.likeCount,
            videoImage:
                experianceProvider.getShareReelsData.data?.videoThumbnailUrl,
            isLike: experianceProvider.getShareReelsData.data?.liked,
            reelsId: experianceProvider.getShareReelsData.data?.id,
            screen: 'UserDetails',
          ),
        ),
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          _setPage(0);
          return false;
        } else {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (_) => CustomExitCard(
              icon: CupertinoIcons.square_arrow_right,
              title: 'Close the app',
              positiveButton: 'exit',
              negativeButton: 'Cancle',
              subTitle: 'Do you want to close and exit app ?',
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          );
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            _screens[_selectedIndex],
            Padding(
              padding: EdgeInsets.all(Platform.isIOS ? 0.0 : 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: Platform.isIOS ? 60 + padding.bottom : 70,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: BottomNavigationBar(
                      currentIndex: _selectedIndex,
                      backgroundColor: Colors.black.withOpacity(0.4),
                      selectedItemColor: AppColors.navigationBarIconColor,
                      selectedIconTheme:
                          const IconThemeData(color: AppColors.blueColor),
                      type: BottomNavigationBarType.fixed,
                      showUnselectedLabels: false,
                      selectedFontSize: 12,
                      selectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedFontSize: 2,
                      onTap: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            icon: Image.asset(
                              'assets/icons/homeup.png',
                              color: AppColors.whiteColor.withOpacity(0.5),
                              height: 25,
                            ),
                            activeIcon: Image.asset(
                              'assets/icons/homeup.png',
                              color: AppColors.navigationBarIconColor,
                              height: 20,
                            ),
                            // backgroundColor: AppColors.blackColor,
                            label: 'Home'),
                        BottomNavigationBarItem(
                            icon: Image.asset(
                              'assets/icons/community.png',
                              color: AppColors.whiteColor.withOpacity(0.5),
                              height: 25,
                            ),
                            activeIcon: Image.asset(
                              'assets/icons/community.png',
                              color: AppColors.navigationBarIconColor,
                              height: 20,
                            ),
                            // backgroundColor: AppColors.blackColor,
                            label: 'Community'),
                        BottomNavigationBarItem(
                            icon: Image.asset(
                              'assets/images/laqta.png',
                              color: AppColors.whiteColor.withOpacity(0.5),
                              height: 25,
                            ),
                            activeIcon: Image.asset(
                              'assets/images/laqta.png',
                              color: AppColors.navigationBarIconColor,
                              height: 20,
                            ),
                            // backgroundColor: AppColors.blackColor,
                            label: 'Laqta'),
                        BottomNavigationBarItem(
                            icon: Image.asset(
                              color: AppColors.whiteColor.withOpacity(0.5),
                              'assets/icons/sedual.png',
                              height: 25,
                            ),
                            activeIcon: Image.asset(
                              'assets/icons/sedual.png',
                              color: AppColors.navigationBarIconColor,
                              height: 20,
                            ),
                            // backgroundColor: AppColors.blackColor,
                            label: 'Planning'),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'assets/icons/chat.png',
                            color: AppColors.whiteColor.withOpacity(0.5),
                            height: 25,
                          ),
                          activeIcon: Image.asset(
                            'assets/icons/chat.png',
                            color: AppColors.navigationBarIconColor,
                            height: 20,
                          ),
                          // backgroundColor: AppColors.blackColor,
                          label: 'Chat',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
