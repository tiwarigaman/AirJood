import 'package:airjood/res/components/maintextfild.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/custom_shimmer.dart';
import '../../../../view_model/following_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import 'experience_screens/reels_user_detail_screen.dart';

class FollowingScreen extends StatefulWidget {
  final int? userId;
  const FollowingScreen({super.key, this.userId});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  void initState() {
    UserViewModel().getToken().then((value) {
      Provider.of<FollowingViewModel>(context, listen: false)
          .followingGetApi(value!, widget.userId!);
    });
    super.initState();
  }

  bool follow = false;
  Map<int, bool> followStates = {};
  handleFollowers(int userId) {
    bool isFollowing =
        followStates[userId] ?? false; // Get current follow state
    bool newFollowState = !isFollowing; // Toggle the follow state
    UserViewModel().getToken().then((token) async {
      // await Provider.of<FollowingViewModel>(context, listen: false).followApi(
      //   token!,
      //   userId,
      //   newFollowState,
      //   context,
      // );
      setState(() {
        followStates[userId] =
            newFollowState; // Update follow state for this user
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          CustomText(
            data:
                'Following (${Provider.of<FollowingViewModel>(context).followingData.data?.data?.length ?? 0})',
            fSize: 20,
            fweight: FontWeight.w700,
            fontColor: AppColors.blackColor,
          ),
          const Spacer(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MainTextFild(
                hintText: 'Search People...',
                prefixIcon: Icon(
                  Icons.search_sharp,
                  color: AppColors.textFildHintColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<FollowingViewModel>(
                builder: (context, value, child) {
                  switch (value.followingData.status) {
                    case Status.LOADING:
                      return const FollowersShimmer();
                    case Status.ERROR:
                      return const FollowersShimmer();
                    case Status.COMPLETED:
                      return ListView.builder(
                        itemCount: value.followingData.data?.data?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data = value.followingData.data?.data?[index];
                          int userId =
                              data?.followedUser?.id ?? 0; // Get user ID

                          bool isFollowing = followStates[userId] ?? false;
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReelsUserDetailScreen(
                                      about: data?.followedUser?.about,
                                      image:
                                          data?.followedUser?.profileImageUrl,
                                      email: data?.followedUser?.email,
                                      number: data?.followedUser?.contactNo,
                                      name: data?.followedUser?.name,
                                      guide: data?.followedUser?.isUpgrade,
                                      createdAt: data?.followedUser?.createdAt,
                                      language: data?.followedUser?.languages,
                                      userId: data?.followedUser?.id,
                                      screen: 'UserDetails',
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${data?.followedUser?.profileImageUrl}',
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            title: CustomText(
                              data: '${data?.followedUser?.name}',
                              fontColor: AppColors.blackTextColor,
                              fSize: 14,
                              fweight: FontWeight.w500,
                            ),
                            subtitle: CustomText(
                              data: '${data?.followedUser?.email}',
                              fontColor: AppColors.greyTextColor,
                              fSize: 14,
                              fweight: FontWeight.w500,
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                handleFollowers(data?.followedUser?.id as int);
                                setState(() {});
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: isFollowing
                                      ? Colors.grey.shade100
                                      : Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: CustomText(
                                    data: isFollowing ? 'Follow' : 'Following',
                                    fontColor: isFollowing
                                        ? AppColors.blackColor
                                        : const Color(0xFF14C7FF),
                                    fSize: 13,
                                    fweight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    default:
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
