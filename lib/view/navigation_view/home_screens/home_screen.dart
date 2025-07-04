// ignore_for_file: deprecated_member_use

import 'package:airjood/model/home_reels_model.dart';
import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/search_widget.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/notification_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/user_details_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/videoPlayer.dart';
import 'package:airjood/view_model/home_reels_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import '../../../res/components/color.dart';
import '../../../view_model/notification_list_view_model.dart';
import '../../../view_model/user_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late PreloadPageController _pageController;
  late TabController _tabController;
  List<Datum> data = [];
  int currentIndex = 0;
  int currentPage = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _pageController = PreloadPageController(initialPage: currentPage);
    _pageController.addListener(_onPageChanged);
    fetchData();
    notification();
    UserViewModel().getUser().then((value) {
      image = value?.profileImageUrl;
      setState(() {});
    });
  }

  void notification() {
    UserViewModel().getToken().then((value) {
      setState(() {});
      Provider.of<NotificationListViewModel>(context, listen: false)
          .notificationListGetApi(value!);
    });
  }

  String? image;

  void _onPageChanged() {
    final homeReelsProvider =
        Provider.of<HomeReelsViewModel>(context, listen: false);
    if (_pageController.page == _pageController.page!.roundToDouble()) {
      setState(() {
        currentPage = _pageController.page!.toInt();
        // isOnPageTurning = false;
      });
      if (currentPage == homeReelsProvider.mainReelsData.length - 1) {
        // fetchData();
      }
    } else if (currentPage.toDouble() != _pageController.page) {
      if ((currentPage.toDouble() - _pageController.page!).abs() > 0.1) {
        setState(() {
          // isOnPageTurning   = true;
        });
      }
    }
  }

  Future<void> fetchData({int? index}) async {
    UserViewModel().getToken().then((value) async {
      final homeReelsProvider =
          Provider.of<HomeReelsViewModel>(context, listen: false);
      homeReelsProvider.setPage(1);
      await homeReelsProvider.homeReelsGetApi(value!, tabIndex: index);
    });
  }

  Future<void> refreshData({int? index}) async {
    UserViewModel().getToken().then((value) async {
      final homeReelsProvider =
          Provider.of<HomeReelsViewModel>(context, listen: false);
      homeReelsProvider.setPage(1);
      homeReelsProvider.clearData();
      await homeReelsProvider.homeReelsGetApi(value!, tabIndex: index);
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final homeReelsProvider = Provider.of<HomeReelsViewModel>(context);
    final notificationProvider =
        Provider.of<NotificationListViewModel>(context);
    return RefreshIndicator(
      onRefresh: refreshData,
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          toolbarHeight: 70,
          actions: [
            const SizedBox(width: 10),
            Expanded(
              child: TabBar(
                onTap: (p0) {
                  refreshData(index: p0);
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
                ],
              ),
            ),
            const SizedBox(width: 30),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    constraints: BoxConstraints.loose(
                      Size(MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height * 0.85),
                    ),
                    isScrollControlled: true,
                    isDismissible: false,
                    enableDrag: false,
                    builder: (_) => const SearchWidget(),
                  );
                },
                child: const Image(
                  image: AssetImage('assets/icons/search.png'),
                  height: 20,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height * 0.85),
                  isScrollControlled: true,
                  enableDrag: false,
                  builder: (_) => const NotificationScreen(),
                ).then((value) {
                  notification();
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: notificationProvider
                            .notificationListData.data?.unreadCount ==
                        0
                    ? const Image(
                        image: AssetImage('assets/icons/notification.png'),
                        height: 20,
                      )
                    : const Image(
                        image: AssetImage('assets/icons/notification_on.png'),
                        height: 20,
                      ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserDetailsScreen(
                      screen: 'MyScreen',
                    ),
                  ),
                ).then((value) {
                  UserViewModel().getUser().then((value) {
                    image = value?.profileImageUrl;
                    //widget.getImage!(value?.profileImageUrl);
                    setState(() {});
                  });
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: '$image',
                  fit: BoxFit.cover,
                  height: 45,
                  width: 45,
                  errorWidget: (context, url, error) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://i.pinimg.com/736x/44/4f/66/444f66853decdc7f052868bf357a0826.jpg',
                        fit: BoxFit.fill,
                        height: 30,
                        width: 30,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Center(
          child: [
            Stack(
              children: [
                PreloadPageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    if (value == homeReelsProvider.mainReelsData.length - 2) {
                      UserViewModel().getToken().then((value) async {
                        final homeReelsProvider =
                            Provider.of<HomeReelsViewModel>(context,
                                listen: false);
                        await homeReelsProvider.homeReelsGetApi(value!);
                      });
                    }
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: homeReelsProvider.mainReelsData.length,
                  scrollDirection: Axis.vertical,
                  preloadPagesCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return VideoPlayerData(
                      data: homeReelsProvider.mainReelsData,
                      currentPage: currentPage,
                      index: index,
                    );
                  },
                ),
              ],
            ),
            homeReelsProvider.mainReelsData.isEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/rejected.png',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 30),
                      const CustomText(
                        data: 'Not found',
                        fontWeight: FontWeight.w700,
                        color: AppColors.whiteTextColor,
                        fSize: 18,
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      PreloadPageView.builder(
                        controller: _pageController,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (value) {
                          if (value ==
                              homeReelsProvider.mainReelsData.length - 2) {
                            UserViewModel().getToken().then((value) async {
                              final homeReelsProvider =
                                  Provider.of<HomeReelsViewModel>(context,
                                      listen: false);
                              await homeReelsProvider.homeReelsGetApi(value!,
                                  tabIndex: 1);
                            });
                          }
                          setState(() {
                            currentPage = value;
                          });
                        },
                        itemCount: homeReelsProvider.mainReelsData.length,
                        scrollDirection: Axis.vertical,
                        preloadPagesCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return VideoPlayerData(
                            data: homeReelsProvider.mainReelsData,
                            currentPage: currentPage,
                            index: index,
                          );
                        },
                      ),
                    ],
                  ),
          ][_tabController.index],
        ),
      ),
    );
  }
}
