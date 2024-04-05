import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/book_now/book_now_main_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/experience_screens/reels_user_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class ReelsUser extends StatefulWidget {
  final String? image;
  final String? name;
  final DateTime? createdAt;
  final String? number;
  final String? about;
  final String? email;
  final List? language;
  final bool? guide;
  final int? userId;
  final DateTime? dateTime;
  final String? discription;
  final String? screen;
  const ReelsUser(
      {super.key,
      this.dateTime,
      this.discription,
      this.image,
      this.name,
      this.createdAt,
      this.number,
      this.about,
      this.email,
      this.language,
      this.guide,
      this.userId,
      this.screen});

  @override
  State<ReelsUser> createState() => _ReelsUserState();
}

class _ReelsUserState extends State<ReelsUser> {
  @override
  Widget build(BuildContext context) {
    String? formattedDate =
        '${widget.dateTime?.day ?? 02}.${widget.dateTime?.month ?? 05}.${widget.dateTime?.year ?? 2024}';

    return Align(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width / 1.1,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, RoutesName.userDetail);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReelsUserDetailScreen(
                        about: widget.about,
                        image: widget.image,
                        email: widget.email,
                        number: widget.number,
                        name: widget.name,
                        guide: widget.guide,
                        createdAt: widget.createdAt,
                        language: widget.language,
                        userId: widget.userId,
                        screen: widget.screen,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: '${widget.image}',
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) {
                      return Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    data: '${widget.name}',
                    fweight: FontWeight.w600,
                    fSize: 17,
                    fontColor: AppColors.whiteTextColor,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 5,
                        color: AppColors.whiteColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        data: formattedDate,
                        fweight: FontWeight.w400,
                        fSize: 12,
                        fontColor: AppColors.whiteTextColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.add,
                        color: AppColors.blueColor,
                      ),
                      Text(
                        'Follow',
                        style: GoogleFonts.inter(
                          color: AppColors.blueColor,
                          fontSize: 12,
                          // fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    enableDrag: false,
                    isDismissible: false,
                    constraints: BoxConstraints.expand(
                        height: MediaQuery.of(context).size.height * 0.90,
                        width: MediaQuery.of(context).size.width),
                    isScrollControlled: true,
                    builder: (_) => const BookNowMainScreen(),
                  );
                },
                child: Container(
                  // width: 100,
                  // height: 38,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0x3314C7FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Book Now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF14C6FF),
                          fontSize: 14,
                          fontFamily: 'Euclid Circular A',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
