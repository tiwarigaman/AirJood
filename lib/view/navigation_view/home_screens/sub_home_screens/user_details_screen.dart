import 'package:airjood/utils/routes/routes_name.dart';
import 'package:airjood/view/navigation_view/home_screens/component/user_detail_component.dart';
import 'package:airjood/view_model/get_booking_list_view_model.dart';
import 'package:airjood/view_model/get_experiance_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/get_reels_view_model.dart';
import '../../../../view_model/get_user_profile_view_model.dart';
import '../../../../view_model/user_view_model.dart';

class UserDetailsScreen extends StatefulWidget {
  final String? screen;
  const UserDetailsScreen({super.key, this.screen});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    UserViewModel().getUser().then((value) {
      name = value?.name;
      createdAt = value?.createdAt;
      number = value?.contactNo;
      email = value?.email;
      gender = value?.gender;
      dob = value?.dob;
      image = value?.profileImageUrl;
      about = value?.about;
      language = value?.languages;
      guide = value?.is_upgrade;
      userId = value?.id;
      review = value?.rating;
      setState(() {});
    });
    UserViewModel().getToken().then((value) {
      token = value;
      setState(() {});
    });
    fetchData();
    fetchExperianceData();
    fetchBookingListData();
    fetchProfileData();
    _pageController.addListener(_onPageChanged);
  }

  int currentPage = 0;
  bool isLoading = false;
  String? token;
  String? image;
  String? name;
  List? language;
  String? about;
  DateTime? createdAt;
  String? number;
  String? email;
  String? gender;
  DateTime? dob;
  bool? guide;
  int? userId;
  int? review;
  void _onPageChanged() {
    final reelsProvider = Provider.of<ReelsViewModel>(context, listen: false);
    if (_pageController.page == _pageController.page!.toInt()) {
      setState(() {
        currentPage = _pageController.page!.toInt();
      });
      if (currentPage == reelsProvider.laqtaData.length - 1) {
        fetchData();
      }
    }
  }

  Future<void> fetchData() async {
    UserViewModel().getToken().then((value) async {
      final reelsProvider = Provider.of<ReelsViewModel>(context, listen: false);
      await reelsProvider.reelsGetApi(value!, currentPage);
    });
  }

  Future<void> fetchExperianceData() async {
    UserViewModel().getToken().then((value) async {
      final experianceProvider =
          Provider.of<GetExperianceListViewModel>(context, listen: false);
      await experianceProvider.getExperianceListApi(value!, currentPage);
    });
  }

  Future<void> fetchBookingListData() async {
    UserViewModel().getToken().then((value) async {
      if(guide == true){
        final bookingProvider =
        Provider.of<GetBookingListViewModel>(context, listen: false);
        await bookingProvider.getBookingListApiUser(value!);
      }else{
        final bookingProvider =
        Provider.of<GetBookingListViewModel>(context, listen: false);
        await bookingProvider.getBookingListApi(value!);
      }
    });
  }
  Future<void> fetchProfileData() async {
    UserViewModel().getToken().then((value) async {
      final counterProvider = Provider.of<ProfileViewModel>(context, listen: false);
      await counterProvider.profileGetApi(value!,userId:  userId!);
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.mainColor,
        statusBarIconBrightness: Brightness.light));
    final reelsProvider = Provider.of<ReelsViewModel>(context);
    final experianceProvider = Provider.of<GetExperianceListViewModel>(context);
    final bookingProvider = Provider.of<GetBookingListViewModel>(context);
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
            borderRadius: BorderRadius.circular(100),
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
              ? const SizedBox()
              : const Icon(
                  Icons.add,
                  color: AppColors.mainColor,
                ),
          widget.screen == 'MyScreen'
              ? const SizedBox()
              : Text(
                  'Follow',
                  style: GoogleFonts.inter(
                    color: AppColors.mainColor,
                    fontSize: 16,
                    // fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutesName.editProfile,
                arguments: {
                  'number': number,
                  'token': token,
                  'image': image,
                  'name': name,
                  'email': email,
                  'gender': gender,
                  'dob': dob,
                  'about': about,
                  'language': language,
                },
              ).then((value) {
                UserViewModel().getUser().then((value) {
                  name = value?.name;
                  createdAt = value?.createdAt;
                  number = value?.contactNo;
                  email = value?.email;
                  gender = value?.gender;
                  dob = value?.dob;
                  image = value?.profileImageUrl;
                  about = value?.about;
                  language = value?.languages;
                  guide = value?.is_upgrade;
                  setState(() {});
                });
              });
            },
            child: SvgPicture.asset(
              'assets/svg/edit.svg',
              height: 22,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.setting);
            },
            child: SvgPicture.asset(
              'assets/svg/setting.svg',
              height: 22,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: UserDetails(
          image: image,
          name: name,
          createdAt: createdAt,
          number: number,
          email: email,
          about: about,
          language: language,
          guide: guide,
          userId: userId,
          item: reelsProvider.laqtaData,
          list: experianceProvider.data2,
          screen: widget.screen,
          bookingList: bookingProvider.data3,
          // userData: userData,
        ),
      ),
    );
  }
}
