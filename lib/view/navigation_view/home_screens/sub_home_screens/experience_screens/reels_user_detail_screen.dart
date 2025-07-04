import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../model/booking_list_model.dart';
import '../../../../../model/conversations_model.dart';
import '../../../../../model/get_experiance_model.dart';
import '../../../../../model/reels_model.dart';
import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';
import '../../../../../view_model/get_booking_list_view_model.dart';
import '../../../../../view_model/get_experiance_list_view_model.dart';
import '../../../../../view_model/get_reels_view_model.dart';
import '../../../../../view_model/get_user_profile_view_model.dart';
import '../../../../../view_model/home_reels_view_model.dart';
import '../../../../../view_model/user_view_model.dart';
import '../../../chat_view/chat_details_screen.dart';
import '../../component/user_detail_component.dart';

class ReelsUserDetailScreen extends StatefulWidget {
  final String? image;
  final String? name;
  final DateTime? createdAt;
  final String? number;
  final String? about;
  final String? email;
  final List? language;
  final bool? guide;
  final DateTime? dob;
  final int? userId;
  final String? screen;
  final bool? isFollow;
  final String? gender;
  final String? role;
  const ReelsUserDetailScreen(
      {super.key,
      this.image,
      this.name,
      this.createdAt,
      this.number,
      this.about,
      this.email,
      this.language,
      this.guide,
      this.userId,
      this.screen,
      this.isFollow, this.dob, this.gender, this.role});

  @override
  State<ReelsUserDetailScreen> createState() => _ReelsUserDetailScreenState();
}

class _ReelsUserDetailScreenState extends State<ReelsUserDetailScreen> {
  final PageController _pageController = PageController();
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      token = value;
      setState(() {});
    });
    fetchData();
    fetchExperianceData();
    fetchProfileData();
    fetchBookingListData();
    _pageController.addListener(_onPageChanged);
    isFollowing = widget.isFollow ?? false;
  }

  void _onPageChanged() {
    if (_pageController.page == _pageController.page!.toInt()) {
      setState(() {
        currentPage = _pageController.page!.toInt();
      });
      if (currentPage == data.length - 1) {
        fetchData();
        fetchExperianceData();
      }
    }
  }

  List<ReelsData> data = [];
  List<Datum> data2 = [];
  List<BookingData> data3 = [];

  Future<void> fetchData() async {
    UserViewModel().getToken().then((value) async {
      final reelsProvider = Provider.of<ReelsViewModel>(context, listen: false);
      await reelsProvider.reelsUserGetApi(widget.userId!, value!, currentPage);
      reelsProvider.reelsData.data?.data?.data?.forEach((element) {
        data.add(element);
      });
    });
  }

  Future<void> fetchExperianceData() async {
    UserViewModel().getToken().then((value) async {
      final experianceProvider =
          Provider.of<GetExperianceListViewModel>(context, listen: false);
      await experianceProvider.getReelsUserExperianceListApi(
          widget.userId!, value!, currentPage);
      experianceProvider.getExperianceData.data?.data?.forEach((element) {
        data2.add(element);
      });
    });
  }

  Future<void> fetchBookingListData() async {
    UserViewModel().getToken().then((value) async {
      final bookingProvider =
          Provider.of<GetBookingListViewModel>(context, listen: false);
      await bookingProvider.getBookingListApiUser(value!,userId: widget.userId);
      setState(() {
        data3.addAll(bookingProvider.getBookingData.data?.data ?? []);
      });
    });
  }

  Future<void> fetchProfileData() async {
    UserViewModel().getToken().then((value) async {
      final counterProvider =
          Provider.of<ProfileViewModel>(context, listen: false);
      await counterProvider.profileGetApi(value!,userId: widget.userId!);
    });
  }

  int currentPage = 0;
  String? token;

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeReelsProvider = Provider.of<HomeReelsViewModel>(context);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.mainColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 35,
              weight: 2,
            ),
          ),
          const CustomText(
            data: 'Profile',
            fSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
          const Spacer(),
          widget.screen == 'MyScreen'
          ?const SizedBox()
              :isFollowing
              ? const SizedBox()
              : const Icon(
                  Icons.add,
                  color: AppColors.mainColor,
                ),
          widget.screen == 'MyScreen' ? const SizedBox() :InkWell(
            onTap: () {
              homeReelsProvider.handleFollowers(
                  context, widget.userId!, widget.isFollow ?? false);
              setState(() {
                isFollowing = !isFollowing;
              });
            },
            child: Text(
              isFollowing ? "Following" : "Follow",
              style: GoogleFonts.inter(
                color: AppColors.mainColor,
                fontSize: 16,
                // fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          if (widget.screen != 'MyScreen')
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatDetailsScreen(
                      user: ConversationsData(
                        id: widget.userId,
                        languages: widget.language,
                        about: widget.about,
                        contactNo: widget.number,
                        dob: widget.dob,
                        gender: widget.gender,
                        name: widget.name,
                        role: widget.role,
                        email: widget.email,
                        profileImageUrl: widget.image,
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.tabBGColor,
                ),
                child: const Icon(CupertinoIcons.chat_bubble_text,color: AppColors.mainColor,size: 22,),
              ),
            ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: UserDetails(
          image: widget.image,
          name: widget.name,
          createdAt: widget.createdAt,
          number: widget.number,
          email: widget.email,
          about: widget.about,
          language: widget.language,
          guide: widget.guide,
          item: data,
          screen: widget.screen,
          userId: widget.userId,
          list: data2,
          bookingList: data3,
        ),
      ),
    );
  }
}
