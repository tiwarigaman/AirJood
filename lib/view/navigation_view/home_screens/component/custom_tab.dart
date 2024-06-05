import 'package:airjood/view/navigation_view/planning_view/screen_widgets/followers.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/following.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../res/components/color.dart';
import '../../planning_view/screen_widgets/all_user_list_widget.dart';

class CustomTabBar extends StatefulWidget {
  final int planId;
  const CustomTabBar({super.key, required this.planId});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int? index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonsTabBar(
          onTap: (p0) {
            index = p0;
            setState(() {});
          },
          controller: _tabController,
          borderWidth: 0,
          backgroundColor: AppColors.mainColor,
          unselectedBackgroundColor: AppColors.tabBGColor,
          splashColor: AppColors.transperent,
          labelSpacing: 7,
          contentPadding: const EdgeInsets.symmetric(horizontal: 19),
          labelStyle: GoogleFonts.nunitoSans(
            color: AppColors.whiteTextColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: GoogleFonts.nunitoSans(
            color: AppColors.mainColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            Tab(text: 'All Users'),
            Tab(text: 'Followers'),
            Tab(text: 'Followings'),
          ],
        ),
        Expanded(
          child: Center(
            child: [
              AllUsers(planId: widget.planId),
              FollowersUser(planId: widget.planId),
              FollowingUser(planId: widget.planId)
            ][_tabController.index],
          ),
        ),
      ],
    );
  }
}


