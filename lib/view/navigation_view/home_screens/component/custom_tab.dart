import 'package:flutter/material.dart';
import '../../../../res/components/color.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int? indexs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: 200,
          child: TabBar(
              onTap: (p0) {
                indexs == p0;
                setState(() {});
              },
              unselectedLabelColor: Colors.white70,
              labelColor: AppColors.whiteColor,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.white70,
              controller: _tabController,
              indicatorWeight: 3,
              labelPadding: EdgeInsets.zero,
              tabs: const [
                Tab(text: 'Discover'),
                Tab(text: 'Followers'),
                // InkWell(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const FollowersScreen()),
                //       );
                //     },
                //     child: const Tab(text: 'Followers'),
                // ),
              ],
          ),
        ),
        Center(
          child: [
            const SizedBox(),
            const SizedBox(),
          ][_tabController.index],
        ),
      ],
    );
  }
}
