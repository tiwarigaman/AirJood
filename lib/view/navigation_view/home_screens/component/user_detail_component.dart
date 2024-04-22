import 'package:airjood/view/navigation_view/home_screens/component/cutom_tab_data.dart';
import 'package:airjood/view/navigation_view/home_screens/component/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../model/booking_list_model.dart';
import '../../../../model/get_experiance_model.dart';
import '../../../../model/reels_model.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import 'experiance_tab.dart';

class UserDetails extends StatefulWidget {
  final String? image;
  final String? name;
  final DateTime? createdAt;
  final String? number;
  final String? about;
  final String? email;
  final List? language;
  final bool? guide;
  final String? screen;
  final int? userId;
  final List<ReelsData>? item;
  final List<Datum>? list;
  final List<BookingData>? bookingList;
  const UserDetails({
    super.key,
    this.name,
    this.createdAt,
    this.number,
    this.email,
    this.image,
    this.about,
    this.language,
    this.guide,
    this.item,
    this.list,
    this.screen,
    this.userId,
    this.bookingList,
  });

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  int rating = 0;
  final size = const SizedBox(
    width: 5,
  );

  String? result;

  @override
  Widget build(BuildContext context) {
    result = widget.language?.join(',');
    if (result != null && result!.isNotEmpty && result!.startsWith(',')) {
      result =
          result?.substring(1); // Remove the first character (which is a comma)
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: UserProfile(
            image: widget.image,
            name: widget.name,
            joinDate: widget.createdAt,
            about: widget.about,
            language: widget.language,
            userId: widget.userId,
            screen: widget.screen,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        widget.about == null || widget.about == ''
            ? const SizedBox()
            : const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: CustomText(
                  data: 'About',
                  fontColor: AppColors.splashTextColor,
                  fweight: FontWeight.w600,
                  fSize: 16,
                ),
              ),
        widget.about == null || widget.about == ''
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomText(
                  data: widget.about,
                  fontColor: AppColors.greyTextColor,
                  fweight: FontWeight.w500,
                  fSize: 14,
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        result == null || result == ''
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/language.svg'),
                    size,
                    size,
                    Expanded(
                      child: CustomText(
                        data: result,
                        fontColor: AppColors.splashTextColor,
                        fweight: FontWeight.w600,
                        fSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        widget.number == null || widget.number == ''
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/call.svg'),
                    size,
                    size,
                    CustomText(
                      data: widget.number,
                      fontColor: AppColors.splashTextColor,
                      fweight: FontWeight.w600,
                      fSize: 15,
                    ),
                  ],
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        widget.email == null || widget.email == ''
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/mail.svg'),
                    size,
                    size,
                    CustomText(
                      data: widget.email,
                      fontColor: AppColors.splashTextColor,
                      fweight: FontWeight.w600,
                      fSize: 15,
                    ),
                  ],
                ),
              ),
        const SizedBox(
          height: 20,
        ),
        widget.guide == false
            ? CustomTabData(
                items: widget.item,
                list: widget.list,
                bookingList: widget.bookingList,
                screen: widget.screen,
              )
            : ExperianceTabData(
                items: widget.item,
                list: widget.list,
                bookingList: widget.bookingList,
                screen: widget.screen,
              ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
