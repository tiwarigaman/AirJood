// ignore_for_file: deprecated_member_use

import 'package:airjood/model/home_reels_model.dart';
import 'package:airjood/view/navigation_view/home_screens/videoPlayer.dart';
import 'package:airjood/view_model/home_reels_view_model.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import '../../../view_model/user_view_model.dart';
import 'component/login_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List videos = [
    'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
  ]; // Set the initial index
  late PreloadPageController _pageController;
  List<Datum> data = [];
  int currentIndex = 0;
  int currentPage = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _pageController = PreloadPageController(initialPage: currentPage);
    _pageController.addListener(_onPageChanged);
    fetchData();
    UserViewModel().getUser().then((value) {
      image = value?.profileImageUrl;
      setState(() {});
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

  Future<void> fetchData() async {
    UserViewModel().getToken().then((value) async {
      final homeReelsProvider =
          Provider.of<HomeReelsViewModel>(context, listen: false);
      homeReelsProvider.setPage(1);
      await homeReelsProvider.homeReelsGetApi(value!);
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final homeReelsProvider = Provider.of<HomeReelsViewModel>(context);

    return RefreshIndicator(
      onRefresh: fetchData,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            PreloadPageView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) {
                if (value == homeReelsProvider.mainReelsData.length - 2) {
                  UserViewModel().getToken().then((value) async {
                    final homeReelsProvider =
                        Provider.of<HomeReelsViewModel>(context, listen: false);
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
            LoginUser(
              image: image,
              getImage: ((val) {
                image = val;
                setState(() {});
              }),
            ),
          ],
        ),
      ),
    );
  }
}
