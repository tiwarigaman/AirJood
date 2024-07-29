import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/followers_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/following_screen.dart';
import 'package:airjood/view_model/get_user_profile_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/user_view_model.dart';


class UserProfile extends StatefulWidget {
  final String? name;
  final DateTime? joinDate;
  final String? image;
  final List? language;
  final String? about;
  final int? userId;
  final String? screen;
  final String? contactNo;
  final DateTime? dob;
  final String? gender;
  final String? email;

  const UserProfile({
    super.key,
    this.name,
    this.joinDate,
    this.image,
    this.language,
    this.about,
    this.userId,
    this.screen,
    this.contactNo,
    this.dob,
    this.gender,
    this.email,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Future<void> fetchProfileData() async {
    UserViewModel().getToken().then((value) async {
      final counterProvider =
          Provider.of<ProfileViewModel>(context, listen: false);
      await counterProvider.profileGetApi(value!,userId: widget.userId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    String? formattedDate =
        '${widget.joinDate?.day ?? '00'}-${widget.joinDate?.month ?? '00'}-${widget.joinDate?.year ?? '0000'}';
    DateTime dateTime = DateFormat('dd-MM-yyyy').parse(formattedDate);
    String result = DateFormat('dd MMM yyyy').format(dateTime);
    const size = SizedBox(
      width: 5,
    );
    final counterProvider = Provider.of<ProfileViewModel>(context);
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.splashTextColor, width: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: '${widget.image}',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://i.pinimg.com/736x/44/4f/66/444f66853decdc7f052868bf357a0826.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data: widget.name,
              color: AppColors.splashTextColor,
              fontWeight: FontWeight.w700,
              fSize: 18,
            ),
            RatingBar(
              initialRating: counterProvider.profileData.data?.rating?.toDouble() ?? 0.0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: const Icon(
                  Icons.star_rounded,
                  color: AppColors.amberColor,
                ),
                half: const Icon(
                  Icons.star_half_rounded,
                  color: AppColors.amberColor,
                ),
                empty: const Icon(
                  Icons.star_rounded,
                  color: AppColors.deviderColor,
                ),
              ),
              itemSize: 20.0,
              itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              ignoreGestures: true,
              onRatingUpdate: (double value) {},
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Joining Date : ',
                    style: GoogleFonts.nunitoSans(
                      color: AppColors.splashTextColor,
                      fontSize: 12,
                      //fontFamily: 'Euclid Circular A',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: result,
                    style: GoogleFonts.nunitoSans(
                      color: AppColors.splashTextColor,
                      fontSize: 13,
                      //fontFamily: 'Euclid Circular A',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 200,
              child: Divider(
                color: AppColors.deviderColor,
                thickness: 1.5,
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FollowersScreen(
                          userId: widget.userId,
                          screen: widget.screen,
                        ),
                      ),
                    ).then((value) {
                      fetchProfileData();
                    });
                  },
                  child: Row(
                    children: [
                      CustomText(
                        fSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackTextColor,
                        data:
                            '${counterProvider.profileData.data?.followersCount ?? 0}',
                      ),
                      size,
                      const CustomText(
                        fSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.splashTextColor,
                        data: 'Followers',
                      ),
                    ],
                  ),
                ),
                size,
                size,
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FollowingScreen(
                          userId: widget.userId,
                          screen: widget.screen,
                        ),
                      ),
                    ).then((value) {
                      fetchProfileData();
                    });
                  },
                  child: Row(
                    children: [
                      CustomText(
                        fSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackTextColor,
                        data:
                            '${counterProvider.profileData.data?.followingsCount ?? 0}',
                      ),
                      size,
                      const CustomText(
                        fSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.splashTextColor,
                        data: 'Following',
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
